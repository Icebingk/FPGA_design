// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Thu Nov 28 14:04:30 2024
// Host        : LAPTOP-C0SBPNAP running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/AX7010_2023.1-course_s1_fpga-18_ad9238_hdmi/vivado_ad9238/vivado_ad9238.srcs/sources_1/ip/ila_0/ila_0_stub.v
// Design      : ila_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2020.1" *)
module ila_0(clk, probe0, probe1, probe2, probe3, probe4)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[11:0],probe1[0:0],probe2[0:0],probe3[23:0],probe4[0:0]" */;
  input clk;
  input [11:0]probe0;
  input [0:0]probe1;
  input [0:0]probe2;
  input [23:0]probe3;
  input [0:0]probe4;
endmodule
