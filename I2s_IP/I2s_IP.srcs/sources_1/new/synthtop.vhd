----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/03/2015 05:39:02 PM
-- Design Name: 
-- Module Name: synthtop - Behavioral
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

library work;
use work.AXI4_lite.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity synthtop is
--  Port ( );
end synthtop;

architecture Behavioral of synthtop is

		constant C_S_AXI_DATA_WIDTH	: integer	:= 32;
		-- Width of S_AXI address bus
		constant C_S_AXI_ADDR_WIDTH	: integer	:= 11;

component Jaxc_I2S 
	port (
		-- Users to add ports here
		CLK_100M	: IN 	std_logic;
		PBDAT 		: out 	std_logic;	-- Audio data out
		BCLK		: out 	std_logic;	-- Bit clock
		PBLRC		: out 	std_logic;	-- Playback sample clock (44100 Hz)

		MCLK 		: out 	std_logic;

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
end component;

component AXI_sim_master_top
		generic(
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		-- Width of S_AXI address bus
		C_S_AXI_ADDR_WIDTH	: integer	:= 11);
  Port ( 
  		DATA_in : in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    		M_AXI_ACLK	: in std_logic;
		-- Global Reset Signal. This Signal is Active LOW
		M_AXI_ARESETN	: in std_logic;
		-- Write address (issued by master, acceped by Slave)
		M_AXI_AWADDR	: out std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		-- Write channel Protection type. This signal indicates the
    		-- privilege and security level of the transaction, and whether
    		-- the transaction is a data access or an instruction access.
		M_AXI_AWPROT	: out std_logic_vector(2 downto 0);
		-- Write address valid. This signal indicates that the master signaling
    		-- valid write address and control information.
		M_AXI_AWVALID	: out std_logic;
		-- Write address ready. This signal indicates that the slave is ready
    		-- to accept an address and associated control signals.
		M_AXI_AWREADY	: in std_logic;
		-- Write data (issued by master, acceped by Slave) 
		M_AXI_WDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		-- Write strobes. This signal indicates which byte lanes hold
    		-- valid data. There is one write strobe bit for each eight
    		-- bits of the write data bus.    
		M_AXI_WSTRB	: out std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		-- Write valid. This signal indicates that valid write
    		-- data and strobes are available.
		M_AXI_WVALID	: out std_logic;
		-- Write ready. This signal indicates that the slave
    		-- can accept the write data.
		M_AXI_WREADY	: in std_logic;
		-- Write response. This signal indicates the status
    		-- of the write transaction.
		M_AXI_BRESP	: in std_logic_vector(1 downto 0);
		-- Write response valid. This signal indicates that the channel
    		-- is signaling a valid write response.
		M_AXI_BVALID	: in std_logic;
		-- Response ready. This signal indicates that the master
    		-- can accept a write response.
		M_AXI_BREADY	: out std_logic;
		-- Read address (issued by master, acceped by Slave)
		M_AXI_ARADDR	: out std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		-- Protection type. This signal indicates the privilege
    		-- and security level of the transaction, and whether the
    		-- transaction is a data access or an instruction access.
		M_AXI_ARPROT	: out std_logic_vector(2 downto 0);
		-- Read address valid. This signal indicates that the channel
    		-- is signaling valid read address and control information.
		M_AXI_ARVALID	: out std_logic;
		-- Read address ready. This signal indicates that the slave is
    		-- ready to accept an address and associated control signals.
		M_AXI_ARREADY	: in std_logic;
		-- Read data (issued by slave)
		M_AXI_RDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		-- Read response. This signal indicates the status of the
    		-- read transfer.
		M_AXI_RRESP	: in std_logic_vector(1 downto 0);
		-- Read valid. This signal indicates that the channel is
    		-- signaling the required read data.
		M_AXI_RVALID	: in std_logic;
		-- Read ready. This signal indicates that the master can
    		-- accept the read data and response information.
		M_AXI_RREADY	: out std_logic);
end component;

		signal S_AXI_in : AXI4_lite_slave_in;
		signal S_AXI_out : AXI4_lite_slave_out;

		signal M_AXI_ACLK: std_logic := '1';
		signal M_AXI_ARESETN : std_logic := '0';
		signal M_AXI_AWADDR	: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		signal M_AXI_AWPROT	: std_logic_vector(2 downto 0);
		signal M_AXI_AWVALID	: std_logic;
		signal M_AXI_AWREADY	: std_logic;
		signal M_AXI_WDATA	: std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		signal M_AXI_WSTRB	: std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		signal M_AXI_WVALID	: std_logic;
		signal M_AXI_WREADY	: std_logic;
		signal M_AXI_BRESP	: std_logic_vector(1 downto 0);
		signal M_AXI_BVALID	: std_logic;
		signal M_AXI_BREADY	: std_logic;
		signal M_AXI_ARADDR	: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		signal M_AXI_ARPROT	: std_logic_vector(2 downto 0);
		signal M_AXI_ARVALID	: std_logic;
		signal M_AXI_ARREADY	: std_logic;
		signal M_AXI_RDATA	: std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		signal M_AXI_RRESP	: std_logic_vector(1 downto 0);
		signal M_AXI_RVALID	: std_logic;
		signal M_AXI_RREADY	: std_logic;
		signal MCLK, BCLK, PBDAT, PBLRC,MUTE : std_logic := '0';
		signal counter,cnt : natural :=0;
		signal DATA_in : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);

begin

M_AXI_ACLK <= not M_AXI_ACLK after 5 ns;
M_AXI_ARESETN <= '1' after 100 ns;

DATA_in <= (OTHERS => '1');

Master : AXI_sim_master_top
	generic map (C_S_AXI_DATA_WIDTH	=> 32,
		C_S_AXI_ADDR_WIDTH	=> 11)
  Port map(   		 
  		DATA_in => DATA_in,
  		M_AXI_ACLK	=> M_AXI_ACLK,
		M_AXI_ARESETN	=> M_AXI_ARESETN,
		M_AXI_AWADDR	=> M_AXI_AWADDR,
		M_AXI_AWPROT	=> M_AXI_AWPROT,
		M_AXI_AWVALID	=> M_AXI_AWVALID,
		M_AXI_AWREADY	=> M_AXI_AWREADY,
		M_AXI_WDATA	=> M_AXI_WDATA,
		M_AXI_WSTRB	=> M_AXI_WSTRB,
		M_AXI_WVALID	=> M_AXI_WVALID,
		M_AXI_WREADY	=> M_AXI_WREADY,
		M_AXI_BRESP	=> M_AXI_BRESP,
		M_AXI_BVALID	=> M_AXI_BVALID,
		M_AXI_BREADY	=> M_AXI_BREADY,
		M_AXI_ARADDR	=> M_AXI_ARADDR,
		M_AXI_ARPROT	=> M_AXI_ARPROT,
		M_AXI_ARVALID	=> M_AXI_ARVALID,
		M_AXI_ARREADY	=> M_AXI_ARREADY,
		M_AXI_RDATA	=> M_AXI_RDATA,
		M_AXI_RRESP	=> M_AXI_RRESP,
		M_AXI_RVALID	=> M_AXI_RVALID,
		M_AXI_RREADY	=> M_AXI_RREADY);


		S_AXI_in.S_AXI_AWADDR	<= M_AXI_AWADDR;
		S_AXI_in.S_AXI_AWPROT	<= M_AXI_AWPROT;
		S_AXI_in.S_AXI_AWVALID	<= M_AXI_AWVALID;
		S_AXI_in.S_AXI_WDATA	<= M_AXI_WDATA;
		S_AXI_in.S_AXI_WSTRB	<= M_AXI_WSTRB;
		S_AXI_in.S_AXI_WVALID	<= M_AXI_WVALID;
		S_AXI_in.S_AXI_BREADY	<= M_AXI_BREADY;
		S_AXI_in.S_AXI_ARADDR	<= M_AXI_ARADDR;
		S_AXI_in.S_AXI_ARPROT	<= M_AXI_ARPROT;
		S_AXI_in.S_AXI_ARVALID	<= M_AXI_ARVALID;
		S_AXI_in.S_AXI_RREADY	<= M_AXI_RREADY;


		M_AXI_AWREADY <= S_AXI_out.S_AXI_AWREADY;
		M_AXI_WREADY	<= S_AXI_out.S_AXI_WREADY;
		M_AXI_BRESP	<= S_AXI_out.S_AXI_BRESP;
		M_AXI_BVALID	<= S_AXI_out.S_AXI_BVALID;
		M_AXI_ARREADY	<= S_AXI_out.S_AXI_ARREADY;
		M_AXI_RDATA	<= S_AXI_out.S_AXI_RDATA;
		M_AXI_RRESP	<= S_AXI_out.S_AXI_RRESP;
		M_AXI_RVALID	<= S_AXI_out.S_AXI_RVALID;



  slave : Jaxc_I2S
    port map(
    	CLK_100M	=> M_AXI_ACLK,
    	PBDAT 		=> PBDAT,
		BCLK		=> BCLK,
		PBLRC		=> PBLRC,
		MCLK 		=> MCLK,

		MUTE 		=> MUTE,

    	S_AXI_ACLK	=> M_AXI_ACLK,
		S_AXI_ARESETN	=> M_AXI_ARESETN,
		S_AXI_AWADDR	=> M_AXI_AWADDR,
		s_AXI_AWPROT	=> M_AXI_AWPROT,
		s_AXI_AWVALID	=> M_AXI_AWVALID,
		s_AXI_AWREADY	=> M_AXI_AWREADY,
		s_AXI_WDATA	=> M_AXI_WDATA,
		s_AXI_WSTRB	=> M_AXI_WSTRB,
		S_AXI_WVALID	=> M_AXI_WVALID,
		S_AXI_WREADY	=> M_AXI_WREADY,
		S_AXI_BRESP	=> M_AXI_BRESP,
		S_AXI_BVALID	=> M_AXI_BVALID,
		S_AXI_BREADY	=> M_AXI_BREADY,
		S_AXI_ARADDR	=> M_AXI_ARADDR,
		S_AXI_ARPROT	=> M_AXI_ARPROT,
		S_AXI_ARVALID	=> M_AXI_ARVALID,
		S_AXI_ARREADY	=> M_AXI_ARREADY,
		S_AXI_RDATA	=> M_AXI_RDATA,
		S_AXI_RRESP	=> M_AXI_RRESP,
		S_AXI_RVALID	=> M_AXI_RVALID,
		S_AXI_RREADY	=> M_AXI_RREADY);

end Behavioral;
