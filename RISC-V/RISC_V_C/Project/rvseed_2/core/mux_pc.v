// +FHDR----------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                       ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : mux_pc.v
// Author        : Rongye
// Created On    : 2022-03-21 22:56
// Last Modified : 2022-04-11 20:24
// ---------------------------------------------------------------------------------
// Description   : Determine the update value of the pc. 
// 决定PC寄存器下一条指令的地址，让PC寄存器进行下一条指令
//
// -FHDR----------------------------------------------------------------------------
`include "rvseed_defines.v"

module mux_pc (
    input                          ena,
    input                          branch,  // branch type 
    input                          zero,    // alu result is zero
    input                          jump,    // jump type 
    input      [`CPU_WIDTH-1:0]    imm,     // immediate  
    input      [`CPU_WIDTH-1:0]    curr_pc, // current pc addr
    output reg [`CPU_WIDTH-1:0]    next_pc  // next pc addr
 );

always @(*) begin
    if (~ena) 
        next_pc = curr_pc;
    else if (branch && ~zero) // bne 
        next_pc = curr_pc + imm;
    else if (jump) // jal 
        next_pc = curr_pc + imm;
    else 
        next_pc = curr_pc + `CPU_WIDTH'h4;   
end
endmodule
