-makelib ies/xil_defaultlib -sv \
  "/opt/Xilinx/Vivado/2016.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies/xpm \
  "/opt/Xilinx/Vivado/2016.3/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/blk_mem_gen_v8_3_4 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_3.v" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../ip/Output_buffer_Block_RAM/sim/Output_buffer_Block_RAM.v" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib

