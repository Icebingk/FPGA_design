`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/26 13:33:19
// Design Name: 
// Module Name: ADC_CLK_Div
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ADC_CLK_Div #(
    parameter DIV_NUM=100
)(
    input Clk,
    input rst_n,
    output reg Clk_Div
);

reg [13:0] cnt;


always @(posedge Clk or negedge rst_n) begin
    if (!rst_n)begin
        cnt <= 14'd0;        
    end else if (cnt == DIV_NUM-1) begin
        cnt <= 14'd0;
    end else begin
        cnt <= cnt + 14'd1;
    end
end

always @(posedge Clk or negedge rst_n) begin
    if (!rst_n) begin
        Clk_Div <= 1'b0;
    end else if(cnt == 14'd0) begin
        Clk_Div <= ~Clk_Div;
    end else begin
        Clk_Div <= Clk_Div;
    end
end

endmodule
