----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/14/2015 04:09:26 PM
-- Design Name: 
-- Module Name: CLK_DIV - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CLK_DIV is
	generic (Division_factor : natural := 4;
	           pos_edge : natural := 1);
    Port ( CLK_in : in STD_LOGIC;
           RSTN : in STD_LOGIC;
           CLK_out : out STD_LOGIC);
end CLK_DIV;

architecture Behavioral of CLK_DIV is

signal CLK_out_int : STD_LOGIC;

signal cnt : natural range 0 to (Division_factor/2)-1;

begin

process(RSTN,CLK_in)
begin
	if pos_edge = 0 then
		if falling_Edge(CLK_in) then
			if (RSTN = '0') then
			cnt <= 0;
			CLK_out_int <= '0';
			else 

				if (cnt = (Division_factor/2)-1) then
					cnt <= 0;
					CLK_out_int <= not CLK_out_int;
				else 
					cnt <= cnt+1;
				end if;
			end if;
		end if;
	else
		if rising_Edge(CLK_in) then
			if (RSTN = '0') then
			cnt <= 0;
			CLK_out_int <= '0';
			else 

				if (cnt = (Division_factor/2)-1) then
					cnt <= 0;
					CLK_out_int <= not CLK_out_int;
				else 
					cnt <= cnt+1;
				end if;
			end if;
		end if;
	end if;
end process;

CLK_out <= CLK_out_int;

end Behavioral;
