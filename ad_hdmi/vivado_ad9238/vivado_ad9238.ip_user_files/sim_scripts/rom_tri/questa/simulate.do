onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib rom_tri_opt

do {wave.do}

view wave
view structure
view signals

do {rom_tri.udo}

run -all

quit -force
