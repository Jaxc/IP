library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.AXI4_lite.all;

entity Jaxc_I2S_v1_0 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S_AXI
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 11
	);
	port (
		-- Users to add ports here
		CLK_100M    : in    std_logic;
		
		PBDAT 		: out 	std_logic;	-- Audio data out
		BCLK		: out 	std_logic;	-- Bit clock
		PBLRC		: out 	std_logic;	-- Playback sample clock (44100 Hz)

		MUTE 		: out 	std_logic;	-- Mute audio output

        MCLK        : out   std_logic;

        int_out 	: out 	std_logic; 
		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S_AXI
		s_axi_aclk	: in std_logic;
		s_axi_aresetn	: in std_logic;
		s_axi_awaddr	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		s_axi_awprot	: in std_logic_vector(2 downto 0);
		s_axi_awvalid	: in std_logic;
		s_axi_awready	: out std_logic;
		s_axi_wdata	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		s_axi_wstrb	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		s_axi_wvalid	: in std_logic;
		s_axi_wready	: out std_logic;
		s_axi_bresp	: out std_logic_vector(1 downto 0);
		s_axi_bvalid	: out std_logic;
		s_axi_bready	: in std_logic;
		s_axi_araddr	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		s_axi_arprot	: in std_logic_vector(2 downto 0);
		s_axi_arvalid	: in std_logic;
		s_axi_arready	: out std_logic;
		s_axi_rdata	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		s_axi_rresp	: out std_logic_vector(1 downto 0);
		s_axi_rvalid	: out std_logic;
		s_axi_rready	: in std_logic
	);
end Jaxc_I2S_v1_0;

architecture arch_imp of Jaxc_I2S_v1_0 is

component clk_wiz_0
port
 (-- Clock in ports
  -- Clock out ports
  clk_out1          : out    std_logic;
  -- Status and control signals
  reset             : in     std_logic;
  locked            : out    std_logic;
  clk_in1           : in     std_logic
 );
end component;

component CLK_DIV is
	generic (Division_factor : natural := 4;
	           pos_edge : natural := 1);
    Port ( CLK_in : in STD_LOGIC;
           RSTN : in STD_LOGIC;
           CLK_out : out STD_LOGIC);
end component;

component Jaxc_slave_AXI 
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
end component;

	signal S_AXI_in : AXI4_lite_slave_in;
	signal S_AXI_out : AXI4_lite_slave_out;
	
    signal MCLK_int :   std_logic;
    signal BCLK_int :   std_logic;
    signal PBLRC_int:   std_logic;

begin

MCLK <= MCLK_int;
BCLK <= BCLK_int;
PBLRC<= PBLRC_int;

  slave : Jaxc_slave_AXI
    port map(
    	PBDAT 		=> PBDAT,
		BCLK		=> BCLK_int,
		PBLRC		=> PBLRC_int,

		MUTE 		=> MUTE,
		int_out 	=> int_out,

    	S_AXI_ACLK	=> S_AXI_ACLK,
		S_AXI_ARESETN	=> S_AXI_ARESETN,
		S_AXI_in => S_AXI_in,
		S_AXI_out => S_AXI_out);


    	S_AXI_in.S_AXI_AWADDR	<= s_AXI_AWADDR;
		S_AXI_in.S_AXI_AWPROT	<= s_AXI_AWPROT;
		S_AXI_in.S_AXI_AWVALID	<= s_AXI_AWVALID;
		S_AXI_in.S_AXI_WDATA	<= s_AXI_WDATA;
		S_AXI_in.S_AXI_WSTRB	<= s_AXI_WSTRB;
		S_AXI_in.S_AXI_WVALID	<= s_AXI_WVALID;
		S_AXI_in.S_AXI_BREADY	<= s_AXI_BREADY;
		S_AXI_in.S_AXI_ARADDR	<= s_AXI_ARADDR;
		S_AXI_in.S_AXI_ARPROT	<= s_AXI_ARPROT;
		S_AXI_in.S_AXI_ARVALID	<= s_AXI_ARVALID;
		S_AXI_in.S_AXI_RREADY	<= s_AXI_RREADY;


		s_AXI_AWREADY <= S_AXI_out.S_AXI_AWREADY;
		s_AXI_WREADY	<= S_AXI_out.S_AXI_WREADY;
		s_AXI_BRESP	<= S_AXI_out.S_AXI_BRESP;
		s_AXI_BVALID	<= S_AXI_out.S_AXI_BVALID;
		s_AXI_ARREADY	<= S_AXI_out.S_AXI_ARREADY;
		s_AXI_RDATA	<= S_AXI_out.S_AXI_RDATA;
		s_AXI_RRESP	<= S_AXI_out.S_AXI_RRESP;
		s_AXI_RVALID	<= S_AXI_out.S_AXI_RVALID;

MCLK_gen: clk_wiz_0
   port map ( 
  -- Clock out ports  
   clk_out1 => MCLK_int,
  -- Status and control signals                
   reset => s_axi_aresetn,
   locked => open,
   -- Clock in ports
   clk_in1 => clk_100M
 );
 
BCLK_gen: CLK_DIV
	generic map(Division_factor => 4,
	           pos_edge => 1)
    Port map( CLK_in => MCLK_int,
           RSTN => S_AXI_ARESETN,
           CLK_out => BCLK_int);
           
PBLRC_gen: CLK_DIV
     generic map(Division_factor => 64,
          pos_edge => 1)
     Port map( CLK_in => BCLK_int,
          RSTN => S_AXI_ARESETN,
          CLK_out => PBLRC_int);

end arch_imp;

