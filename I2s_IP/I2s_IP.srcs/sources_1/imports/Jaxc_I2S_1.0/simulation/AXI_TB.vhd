library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.AXI4_lite.all;

entity AXI_I2S_TB is

end AXI_I2S_TB;



architecture Testbench of AXI_I2S_TB is
	signal sys_clk,reset,MCLK, BCLK, PBDAT, PBLRC,MUTE, new_sample_r, new_sample_l : std_logic := '0';
	type array_type is array (0 to 10) of STD_LOGIC_VECTOR(31 downto 0);
	signal Sample_in_right,Sample_in_left : array_type
		:= (1 => (others => '1'),
			3 => (others => '1'),
			5 => (others => '1'),
			7 => (others => '1'),
			9 => (others => '1'),
			others => (others => '0'));

	signal counter, cnt: natural;

component Jaxc_I2S_v1_0_S_AXI
	port (
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
end component;

begin

sys_clk <= not sys_clk after 5 ns;
reset <= '1' after 100 ns;

MCLK <= not MCLK after 40690.104166667 ps;

process(MCLK)
begin
	if rising_edge(MCLK) then
		if counter = 1 then
			BCLK <= not BCLK;
			counter <= 0;
		else
			counter <= counter +1;
		end if;

		if cnt = 127 then
			PBLRC <= not PBLRC;
			cnt <= 0;
		else 
			cnt <= cnt +1;
		end if;
	end if;
end process;

process(new_sample_r)
begin
	if rising_edge(new_sample_r) then
		Sample_in_right(0 to 9) <= Sample_in_right(1 to 10);
		Sample_in_right(10) <= (others => '0');
	end if;
end process;

process(new_sample_l)
begin
	if rising_edge(new_sample_l) then
		Sample_in_left(0 to 9) <= Sample_in_left(1 to 10);
		Sample_in_left(10) <= (others => '0');
	end if;
end process;

I2S : Jaxc_I2S_v1_0_S_AXI

	port map (
		-- Users to add ports here

		PBDAT 		=> PBDAT,
		BCLK		=> BCLK,
		PBLRC		=> PBLRC,

		MUTE 		=> MUTE,



		-- User ports ends
		-- Do not modify the ports beyond this line

		-- Global Clock Signal
		S_AXI_ACLK	=> sys_clk,
		-- Global Reset Signal. This Signal is Active LOW
		S_AXI_ARESETN	=> reset,
		S_AXI_in => S_AXI_in,
		S_AXI_out  => S_AXI_out

);

end Testbench;
