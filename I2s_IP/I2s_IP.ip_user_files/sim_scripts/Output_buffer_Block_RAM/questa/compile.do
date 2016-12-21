vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm
vlib msim/blk_mem_gen_v8_3_4

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm
vmap blk_mem_gen_v8_3_4 msim/blk_mem_gen_v8_3_4

vlog -work xil_defaultlib -64 -sv \
"/opt/Xilinx/Vivado/2016.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"/opt/Xilinx/Vivado/2016.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work blk_mem_gen_v8_3_4 -64 \
"../../../ipstatic/simulation/blk_mem_gen_v8_3.v" \

vlog -work xil_defaultlib -64 \
"../../../ip/Output_buffer_Block_RAM/sim/Output_buffer_Block_RAM.v" \


vlog -work xil_defaultlib "glbl.v"

