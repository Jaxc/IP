onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+Output_buffer_Block_RAM -L xil_defaultlib -L xpm -L blk_mem_gen_v8_3_4 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.Output_buffer_Block_RAM xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {Output_buffer_Block_RAM.udo}

run -all

endsim

quit -force
