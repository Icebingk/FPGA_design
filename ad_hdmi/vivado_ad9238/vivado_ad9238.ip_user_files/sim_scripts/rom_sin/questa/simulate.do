onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib rom_sin_opt

do {wave.do}

view wave
view structure
view signals

do {rom_sin.udo}

run -all

quit -force
