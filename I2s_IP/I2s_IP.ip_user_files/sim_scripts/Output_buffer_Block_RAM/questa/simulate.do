onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib Output_buffer_Block_RAM_opt

do {wave.do}

view wave
view structure
view signals

do {Output_buffer_Block_RAM.udo}

run -all

quit -force
