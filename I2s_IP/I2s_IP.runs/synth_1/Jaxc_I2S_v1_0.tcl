# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config  -ruleid {2147483645}  -id {IP_Flow 19-3152}  -string {{WARNING: [IP_Flow 19-3152] Bus Interface 'PBLRC': ASSOCIATED_BUSIF bus '' does not exist.}}  -suppress 
set_msg_config  -ruleid {2147483646}  -id {IP_Flow 19-3152}  -string {{WARNING: [IP_Flow 19-3152] Bus Interface 'BCLK': ASSOCIATED_BUSIF bus '' does not exist.}}  -suppress 
set_msg_config  -ruleid {2147483647}  -id {Vivado 12-3481}  -string {{ERROR: [Vivado 12-3481] Cannot replace a file with itself: '/home/jaxc/FPGA/IP/I2s_IP/I2s_IP.srcs/sources_1/ip/blk_mem_gen_0/BLK_init.coe'}}  -suppress 
create_project -in_memory -part xc7z010clg400-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/jaxc/FPGA/IP/I2s_IP/I2s_IP.cache/wt [current_project]
set_property parent.project_path /home/jaxc/FPGA/IP/I2s_IP/I2s_IP.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_repo_paths /home/jaxc/FPGA/IP [current_project]
set_property ip_cache_permissions disable [current_project]
add_files /home/jaxc/FPGA/IP/I2s_IP/I2s_IP.srcs/sources_1/ip/Output_buffer_Block_RAM/BLK_init.coe
add_files -quiet /home/jaxc/FPGA/IP/I2s_IP/I2s_IP.srcs/clk_wiz_0/ip/clk_wiz_0/clk_wiz_0.dcp
set_property used_in_implementation false [get_files /home/jaxc/FPGA/IP/I2s_IP/I2s_IP.srcs/clk_wiz_0/ip/clk_wiz_0/clk_wiz_0.dcp]
read_vhdl -library xil_defaultlib {
  /home/jaxc/FPGA/IP/I2s_IP/I2s_IP.srcs/sources_1/imports/Jaxc_I2S_1.0/hdl/cross_domain_bus.vhd
  /home/jaxc/FPGA/IP/I2s_IP/I2s_IP.srcs/sources_1/imports/Jaxc_I2S_1.0/hdl/AXI_4_lite_package.vhd
  /home/jaxc/FPGA/IP/I2s_IP/I2s_IP.srcs/sources_1/imports/Jaxc_I2S_1.0/hdl/I2S_controller.vhd
  /home/jaxc/FPGA/IP/I2s_IP/I2s_IP.srcs/sources_1/imports/Jaxc_I2S_1.0/hdl/cross_domain_bit.vhd
  /home/jaxc/FPGA/IP/I2s_IP/I2s_IP.srcs/sources_1/imports/new/CLK_DIV.vhd
  /home/jaxc/FPGA/IP/I2s_IP/I2s_IP.srcs/sources_1/imports/Jaxc_I2S_1.0/hdl/Jaxc_Slave_axi.vhd
  /home/jaxc/FPGA/IP/I2s_IP/I2s_IP.srcs/sources_1/imports/Jaxc_I2S_1.0/hdl/Jaxc_I2S_v1_0.vhd
}
read_ip -quiet /home/jaxc/FPGA/IP/I2s_IP/I2s_IP.srcs/sources_1/ip/Output_buffer_Block_RAM/Output_buffer_Block_RAM.xci
set_property used_in_implementation false [get_files -all /home/jaxc/FPGA/IP/I2s_IP/I2s_IP.srcs/sources_1/ip/Output_buffer_Block_RAM/Output_buffer_Block_RAM_ooc.xdc]
set_property is_locked true [get_files /home/jaxc/FPGA/IP/I2s_IP/I2s_IP.srcs/sources_1/ip/Output_buffer_Block_RAM/Output_buffer_Block_RAM.xci]

foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/jaxc/FPGA/IP/I2s_IP/I2s_IP.srcs/constrs_1/imports/constraints/i2s.xdc
set_property used_in_implementation false [get_files /home/jaxc/FPGA/IP/I2s_IP/I2s_IP.srcs/constrs_1/imports/constraints/i2s.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top Jaxc_I2S_v1_0 -part xc7z010clg400-1


write_checkpoint -force -noxdef Jaxc_I2S_v1_0.dcp

catch { report_utilization -file Jaxc_I2S_v1_0_utilization_synth.rpt -pb Jaxc_I2S_v1_0_utilization_synth.pb }