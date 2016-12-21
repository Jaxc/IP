-- Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2015.2.1 (lin64) Build 1302555 Wed Aug  5 13:06:02 MDT 2015
-- Date        : Mon Nov  2 18:44:17 2015
-- Host        : Lappytoppy running 64-bit Linux Mint 17.2 Rafaela
-- Command     : write_vhdl -force -mode funcsim
--               /home/jaxc/FPGA/IP/I2s_IP/I2s_IP.srcs/sources_1/ip/AXI_sim_master_top_0/AXI_sim_master_top_0_funcsim.vhdl
-- Design      : AXI_sim_master_top_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity AXI_sim_master_top_0 is
  port (
    M_AXI_ACLK : in STD_LOGIC;
    M_AXI_ARESETN : in STD_LOGIC;
    M_AXI_AWADDR : out STD_LOGIC_VECTOR ( 10 downto 0 );
    M_AXI_AWPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_AWVALID : out STD_LOGIC;
    M_AXI_AWREADY : in STD_LOGIC;
    M_AXI_WDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_WSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_WVALID : out STD_LOGIC;
    M_AXI_WREADY : in STD_LOGIC;
    M_AXI_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_BVALID : in STD_LOGIC;
    M_AXI_BREADY : out STD_LOGIC;
    M_AXI_ARADDR : out STD_LOGIC_VECTOR ( 10 downto 0 );
    M_AXI_ARPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_ARVALID : out STD_LOGIC;
    M_AXI_ARREADY : in STD_LOGIC;
    M_AXI_RDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_RVALID : in STD_LOGIC;
    M_AXI_RREADY : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of AXI_sim_master_top_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of AXI_sim_master_top_0 : entity is "AXI_sim_master_top_0,AXI_sim_master_top,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of AXI_sim_master_top_0 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of AXI_sim_master_top_0 : entity is "AXI_sim_master_top,Vivado 2015.2.1";
end AXI_sim_master_top_0;

architecture STRUCTURE of AXI_sim_master_top_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
begin
  M_AXI_AWADDR(10) <= \<const0>\;
  M_AXI_AWADDR(9) <= \<const0>\;
  M_AXI_AWADDR(8) <= \<const0>\;
  M_AXI_AWADDR(7) <= \<const0>\;
  M_AXI_AWADDR(6) <= \<const0>\;
  M_AXI_AWADDR(5) <= \<const0>\;
  M_AXI_AWADDR(4) <= \<const0>\;
  M_AXI_AWADDR(3) <= \<const0>\;
  M_AXI_AWADDR(2) <= \<const0>\;
  M_AXI_AWADDR(1) <= \<const0>\;
  M_AXI_AWADDR(0) <= \<const0>\;
  M_AXI_AWVALID <= \<const1>\;
  M_AXI_BREADY <= \<const0>\;
  M_AXI_WDATA(31) <= \<const0>\;
  M_AXI_WDATA(30) <= \<const0>\;
  M_AXI_WDATA(29) <= \<const0>\;
  M_AXI_WDATA(28) <= \<const0>\;
  M_AXI_WDATA(27) <= \<const0>\;
  M_AXI_WDATA(26) <= \<const0>\;
  M_AXI_WDATA(25) <= \<const0>\;
  M_AXI_WDATA(24) <= \<const0>\;
  M_AXI_WDATA(23) <= \<const0>\;
  M_AXI_WDATA(22) <= \<const0>\;
  M_AXI_WDATA(21) <= \<const0>\;
  M_AXI_WDATA(20) <= \<const0>\;
  M_AXI_WDATA(19) <= \<const0>\;
  M_AXI_WDATA(18) <= \<const0>\;
  M_AXI_WDATA(17) <= \<const0>\;
  M_AXI_WDATA(16) <= \<const0>\;
  M_AXI_WDATA(15) <= \<const0>\;
  M_AXI_WDATA(14) <= \<const0>\;
  M_AXI_WDATA(13) <= \<const0>\;
  M_AXI_WDATA(12) <= \<const0>\;
  M_AXI_WDATA(11) <= \<const0>\;
  M_AXI_WDATA(10) <= \<const0>\;
  M_AXI_WDATA(9) <= \<const0>\;
  M_AXI_WDATA(8) <= \<const0>\;
  M_AXI_WDATA(7) <= \<const0>\;
  M_AXI_WDATA(6) <= \<const0>\;
  M_AXI_WDATA(5) <= \<const0>\;
  M_AXI_WDATA(4) <= \<const0>\;
  M_AXI_WDATA(3) <= \<const0>\;
  M_AXI_WDATA(2) <= \<const0>\;
  M_AXI_WDATA(1) <= \<const0>\;
  M_AXI_WDATA(0) <= \<const0>\;
  M_AXI_WVALID <= \<const0>\;
  M_AXI_ARVALID <= 'Z';
  M_AXI_RREADY <= 'Z';
  M_AXI_ARADDR(0) <= 'Z';
  M_AXI_ARADDR(1) <= 'Z';
  M_AXI_ARADDR(2) <= 'Z';
  M_AXI_ARADDR(3) <= 'Z';
  M_AXI_ARADDR(4) <= 'Z';
  M_AXI_ARADDR(5) <= 'Z';
  M_AXI_ARADDR(6) <= 'Z';
  M_AXI_ARADDR(7) <= 'Z';
  M_AXI_ARADDR(8) <= 'Z';
  M_AXI_ARADDR(9) <= 'Z';
  M_AXI_ARADDR(10) <= 'Z';
  M_AXI_ARPROT(0) <= 'Z';
  M_AXI_ARPROT(1) <= 'Z';
  M_AXI_ARPROT(2) <= 'Z';
  M_AXI_AWPROT(0) <= 'Z';
  M_AXI_AWPROT(1) <= 'Z';
  M_AXI_AWPROT(2) <= 'Z';
  M_AXI_WSTRB(0) <= 'Z';
  M_AXI_WSTRB(1) <= 'Z';
  M_AXI_WSTRB(2) <= 'Z';
  M_AXI_WSTRB(3) <= 'Z';
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
VCC: unisim.vcomponents.VCC
     port map (
      P => \<const1>\
    );
end STRUCTURE;
