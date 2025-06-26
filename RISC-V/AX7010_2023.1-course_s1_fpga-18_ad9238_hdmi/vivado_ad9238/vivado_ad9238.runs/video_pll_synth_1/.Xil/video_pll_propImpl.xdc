set_property SRC_FILE_INFO {cfile:e:/FPGA/RISC-V/AX7010_2023.1-course_s1_fpga-18_ad9238_hdmi/vivado_ad9238/vivado_ad9238.srcs/sources_1/ip/video_pll/video_pll.xdc rfile:../../../vivado_ad9238.srcs/sources_1/ip/video_pll/video_pll.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
current_instance inst
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.2
