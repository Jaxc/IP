library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.AXI4_lite.all;

entity Jaxc_slave_AXI is
	port (
		-- Users to add ports here

		PBDAT 		: out 	std_logic;	-- Audio data out
		BCLK		: in 	std_logic;	-- Bit clock
		PBLRC		: in 	std_logic;	-- Playback sample clock (44100 Hz)

		MUTE 		: out 	std_logic;	-- Mute audio output


		-- Interupt

		int_out 	: out 	std_logic; 


		-- User ports ends
		-- Do not modify the ports beyond this line

		-- Global Clock Signal
		S_AXI_ACLK	: in std_logic;
		-- Global Reset Signal. This Signal is Active LOW
		S_AXI_ARESETN	: in std_logic;
		-- Write address (issued by master, acceped by Slave)
		S_AXI_in : in AXI4_lite_slave_in;
		S_AXI_out : out AXI4_lite_slave_out
	);
end Jaxc_slave_AXI;

architecture arch_imp of Jaxc_slave_AXI is

	-- AXI4LITE signals
	signal axi_bresp	: std_logic_vector(1 downto 0);
	signal axi_arready	: std_logic;
	signal axi_rdata	: std_logic_vector(31 downto 0);
	signal axi_rresp	: std_logic_vector(1 downto 0);
	signal axi_rvalid	: std_logic;

	-- Example-specific design signals
	-- local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
	-- ADDR_LSB is used for addressing 32/64 bit registers/memories
	-- ADDR_LSB = 2 for 32 bits (n downto 2)
	-- ADDR_LSB = 3 for 64 bits (n downto 3)
	constant ADDR_LSB  : integer := (32/32)+ 1;
	constant OPT_MEM_ADDR_BITS : integer := 8;
	constant OPT_MEM_OUT_ADDR_BITS : integer := 8 - 1 ;
	------------------------------------------------
	---- Signals for user logic register space example
	--------------------------------------------------
	---- Number of Slave Registers 512

	--type array_type is array (0 to 255) of std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg_in : std_logic_vector(31 downto 0);
	signal slv_reg_out : std_logic_vector(63 downto 0);

	signal write_ram : std_logic_vector(0 to 0);

	signal Sample_in : STD_LOGIC_VECTOR(63 downto 0);
	signal Sample_in_buf : STD_LOGIC_VECTOR(63 downto 0);
	signal new_sample : STD_LOGIC_VECTOR(2 downto 0);
	
	signal cnt_out	: natural range 0 to 255;

	signal byte_index	: integer;

	signal loc_addr :std_logic_vector(8 downto 0); 
	signal read_addr : std_logic_vector(7 downto 0);
	signal RAM_read_enable : std_logic;
	signal axi_read_addr : std_logic_vector(8 downto 0);

	signal read_enable : std_logic;
	signal req_read : std_logic;

	signal buffer_full : std_logic;

	signal axi_read_valid: std_logic;
	signal axi_rec_read : std_logic;
	
	component I2S_controller 
		Port ( 
			   reset   : in STD_LOGIC;
	           BCLK : in STD_LOGIC;
	           PBDAT : out STD_LOGIC;
	           PBLRC : in STD_LOGIC;
	           MUTE : out STD_LOGIC;
			   Sample_in : in STD_LOGIC_VECTOR (63 downto 0);
			   req_new_sample : out STD_LOGIC);
	end component;

COMPONENT Output_buffer_Block_RAM
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    clkb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    addrb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
  );
END COMPONENT;

	component cross_domain_bus 
	generic (
		bus_width : natural;
		fast : natural;
		tra_edge : natural;
		rec_edge : natural
		);
	Port ( 
			async_rst : in std_logic;

			clk_a : in std_logic;
			data_in : in std_logic_vector(bus_width-1 downto 0);

			clk_b : in std_logic;
			data_out : out std_logic_vector(bus_width-1 downto 0)

		   );
	end component;

component cross_domain_bit
	generic (
		fast : natural;
		tra_edge : natural;
		rec_edge : natural
		);
	Port ( 
			async_rst : in std_logic;

			clk_a : in std_logic;
			data_in : in std_logic;

			clk_b : in std_logic;
			data_out : out std_logic

		   );
end component;

type write_state_type is (Write_address,write_data,write_ack);
type read_state_type is (Read_address, Read_data);



type record_type is
record
	write_state : write_state_type;
	read_state : read_state_type;
	axi_awready : std_logic;
	axi_wready 	: std_logic;
	axi_bvalid 	: std_logic;
	axi_arready : std_logic;
	axi_rresp 	: std_logic_vector(1 downto 0);
	axi_rvalid 	: std_logic;
end record;

signal crnt, nxt : record_type;


begin

-- Combatorial process
process(S_AXI_in,crnt,buffer_full)
begin
	nxt.axi_awready <= '0';
	nxt.axi_wready <= '0';
	nxt.axi_bvalid <= '0';

	nxt.axi_arready <= '0';
	nxt.axi_rvalid <= '0';
	nxt.axi_rresp 	<= "00";

	nxt.write_state <= crnt.write_state;
	nxt.read_state <= crnt.read_state;
	axi_bresp <= "00";

	case crnt.write_state is

	when Write_address => 
		if ((S_AXI_in.S_AXI_AWVALID = '1') and (crnt.axi_awready = '1')) then
			nxt.write_state <= write_data;
		else 
			nxt.axi_awready <= '1';
		end if;

	when write_data =>
					
			if ((S_AXI_in.S_AXI_WVALID = '1') and (crnt.axi_wready = '1')) then
				nxt.write_state <= write_ack;
			else 
				nxt.axi_wready <= '1';
			end if;


	when write_ack =>
		if (buffer_full = '0') then
			axi_bresp <= "00";
			if ((S_AXI_in.S_AXI_BREADY = '1') and (crnt.axi_bvalid = '1')) then
				nxt.write_state <= Write_address;
			else 
				nxt.axi_bvalid <= '1';
			end if;
		else 
			null; -- Do nothing until RAM can be written.
			--assert false report "collision avoided" severity error;
		end if;
	end case;


	-- Read state machine

	case crnt.read_state is

		when Read_address => 
			
			if ((S_AXI_in.S_AXI_ARVALID = '1') and (crnt.axi_arready = '1')) then
				nxt.read_state <= Read_data;
			else 
				nxt.axi_arready <= '1';
			end if;

		when Read_data => 

			if ((S_AXI_in.S_AXI_RREADY = '1' ) and (crnt.axi_rvalid = '1')) then
				nxt.read_state <= Read_address;
			else 
				nxt.axi_rvalid <= '1';
			end if;

	end case;


end process;

-- Sequential process
process(S_AXI_ACLK)
begin
	if rising_edge(S_AXI_ACLK) then

		if S_AXI_ARESETN = '0' then

			S_AXI_out.S_AXI_AWREADY	<= '0';
			S_AXI_out.S_AXI_WREADY	<= '0';
			S_AXI_out.S_AXI_BRESP	<= "00";
			S_AXI_out.S_AXI_BVALID	<= '0';
			S_AXI_out.S_AXI_ARREADY	<= '0';
			S_AXI_out.S_AXI_RDATA	<= x"4A617863";
			S_AXI_out.S_AXI_RRESP	<= "00";
			S_AXI_out.S_AXI_RVALID	<= '0';	

			loc_addr <= (others => '0');
			slv_reg_in <= (others => '0');		
			write_ram <= "0";
			buffer_full <= '0';

			axi_read_valid <= '0';
			axi_rec_read <= '0';
		else 

			axi_read_valid <= '0';
			axi_rec_read <= '0';

			crnt <= nxt;

			write_ram <= "0";

			S_AXI_out.S_AXI_AWREADY	<= nxt.axi_awready;
			S_AXI_out.S_AXI_WREADY	<= nxt.axi_wready;
			S_AXI_out.S_AXI_BRESP	<= axi_bresp;
			S_AXI_out.S_AXI_BVALID	<= nxt.axi_bvalid;
			S_AXI_out.S_AXI_ARREADY	<= nxt.axi_arready;
			if loc_addr(0) = '0' then
				S_AXI_out.S_AXI_RDATA	<= slv_reg_out(31 downto 0);
			else 
				S_AXI_out.S_AXI_RDATA	<= slv_reg_out(63 downto 32);
			end if;
			S_AXI_out.S_AXI_RRESP	<= nxt.axi_rresp;
			S_AXI_out.S_AXI_RVALID	<= nxt.axi_rvalid;

			if ((S_AXI_in.S_AXI_AWVALID = '1') and (crnt.write_state = Write_address)) then
				loc_addr <= S_AXI_in.S_AXI_AWADDR(10 downto 2);
			elsif ((S_AXI_in.S_AXI_WVALID = '1') and (crnt.write_state = write_data)) then
				slv_reg_in <= S_AXI_in.S_AXI_WDATA;
				buffer_full <= '1';
			end if;

			if ((S_AXI_in.S_AXI_ARVALID = '1') and (crnt.read_state = Read_address)) then
				loc_addr <= S_AXI_in.S_AXI_ARADDR(10 downto 2);
				axi_rec_read <= '1';
			end if;


			if (req_read = '0') and (read_enable = '0') then
				if buffer_full = '1' then
					buffer_full <= '0';
					write_ram <= "1";
				elsif axi_rec_read = '1'then
					axi_read_valid <= '1';
				end if;

			end if;

		end if;

	end if;

--		AXI_ARREADY	<= '1';
--		AXI_RDATA 	<= x"4A617863";
--		AXI_RRESP 	<= "00";
--		AXI_RVALID	<= '1';

end process;


	process(S_AXI_ACLK)
	begin
		if rising_edge(S_AXI_ACLK) then
			if S_AXI_ARESETN = '0' then
				new_sample(0) <= '0';
				cnt_out <= 0;
				Sample_in_buf <= (others => '0');
				read_enable <= '0';
				req_read <= '0';
				int_out <= '0';
			else
				new_sample(0) <= new_sample(1);
				int_out <= '0';
				if ((req_read = '1') and (write_ram = "0")) then
					read_enable <= '1';
					req_read <= '0';
				else
					read_enable <= '0';
				end if;

				if (new_sample(0) = '0') AND (new_sample(1) = '1') then
					req_read <= '1';
					if cnt_out >=255 then
						cnt_out <= 0;
						int_out <= '1'; -- activate interupt to request new values;
					else 
						cnt_out <= cnt_out + 1;
					end if;
				end if;

				if (axi_read_valid = '1') then
					read_addr <= loc_addr(8 downto 1);
				else
					read_addr <= STD_LOGIC_VECTOR(to_unsigned(cnt_out,8));
				end if;
				Sample_in_buf <= slv_reg_out;

			end if;
		end if;
	end process;

	--process(BCLK)
	--begin
	--	if falling_edge(BCLK) then
	--		Sample_in_right <= Sample_in_right_buf;
	--		Sample_in_left <= Sample_in_left_buf;

	--	end if;
	--end process;

RAM_read_enable <= read_enable or axi_read_valid;

assert (read_enable nand axi_read_valid) = '1' report "READ COLLISION" severity failure;

new_input_sample :  cross_domain_bus
	generic map(
		bus_width => 64,
		fast => 0,
		tra_edge => 1,
		rec_edge => 0
		)
	Port map ( 
			async_rst => S_AXI_ARESETN,

			clk_a => S_AXI_ACLK,
			data_in => Sample_in_buf,

			clk_b => BCLK,
			data_out => Sample_in
		   );

req_sample : cross_domain_bit
	generic map(
		fast => 1,
		tra_edge => 0,
		rec_edge => 1
		)
	Port map( 
			async_rst => S_AXI_ARESETN,

			clk_a => BCLK,
			data_in => new_sample(2),

			clk_b => S_AXI_ACLK,
			data_out => new_sample(1)

		   );


	-- Add user logic here

RAM : Output_buffer_Block_RAM
  PORT MAP (
    clka => S_AXI_ACLK,
    wea => write_ram,
    addra => loc_addr,
    dina => slv_reg_in,
    clkb => S_AXI_ACLK,
    enb => RAM_read_enable,
    addrb => read_addr,
    doutb => slv_reg_out
  );

I2S : I2S_controller 
	Port map ( 
		   reset	=> S_AXI_ARESETN,
           BCLK		=> BCLK,
           PBDAT	=> PBDAT,
           PBLRC	=> PBLRC,
           MUTE		=> MUTE,
           Sample_in => Sample_in,
		   req_new_sample => new_sample(2)
		   );

end arch_imp;
