onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib adc_pll_opt

do {wave.do}

view wave
view structure
view signals

do {adc_pll.udo}

run -all

quit -force
