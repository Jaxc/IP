----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/02/2015 08:09:10 AM
-- Design Name: 
-- Module Name: AXI_master - Behavioral
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

entity AXI_sim_master_top is
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
end AXI_sim_master_top;

architecture Behavioral of AXI_sim_master_top is

component AXI_master
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
		M_AXI_RREADY	: out std_logic


);
end component;
begin

axi_master_1 : AXI_master
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
		M_AXI_RREADY	=> M_AXI_RREADY

);
     
     
end Behavioral;
