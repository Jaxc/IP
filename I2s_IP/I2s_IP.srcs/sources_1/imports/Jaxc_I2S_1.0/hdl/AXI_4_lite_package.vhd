library IEEE;
use IEEE.std_logic_1164.all;

package AXI4_lite is

type AXI4_lite_slave_in is
record
		S_AXI_AWADDR	: std_logic_vector(10 downto 0);
		S_AXI_AWPROT	: std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: std_logic;
		S_AXI_WDATA		: std_logic_vector(31 downto 0);
		S_AXI_WSTRB		: std_logic_vector((32/8)-1 downto 0);
		S_AXI_WVALID	: std_logic;
		S_AXI_BREADY	: std_logic;
		S_AXI_ARADDR	: std_logic_vector(10 downto 0);
		S_AXI_ARPROT	: std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: std_logic;
		S_AXI_RREADY	: std_logic;
end record;

type AXI4_lite_slave_out is
record
		S_AXI_AWREADY	: std_logic;
		S_AXI_WREADY	: std_logic;
		S_AXI_BRESP		: std_logic_vector(1 downto 0);
		S_AXI_BVALID	: std_logic;
		S_AXI_ARREADY	: std_logic;
		S_AXI_RDATA		: std_logic_vector(32-1 downto 0);
		S_AXI_RRESP		: std_logic_vector(1 downto 0);
		S_AXI_RVALID	: std_logic;

end record;

end AXI4_lite;
