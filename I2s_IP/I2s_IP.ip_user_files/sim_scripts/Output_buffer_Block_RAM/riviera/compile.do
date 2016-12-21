vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm
vlib riviera/blk_mem_gen_v8_3_4

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm
vmap blk_mem_gen_v8_3_4 riviera/blk_mem_gen_v8_3_4

vlog -work xil_defaultlib  -sv2k12 \
"/opt/Xilinx/Vivado/2016.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"/opt/Xilinx/Vivado/2016.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work blk_mem_gen_v8_3_4  -v2k5 \
"../../../ipstatic/simulation/blk_mem_gen_v8_3.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../ip/Output_buffer_Block_RAM/sim/Output_buffer_Block_RAM.v" \


vlog -work xil_defaultlib "glbl.v"

