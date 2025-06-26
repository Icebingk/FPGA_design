`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/26 01:45:44
// Design Name: 
// Module Name: SPWM_Time
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


module SPWM_Time(
    input sys_clk,
    input rst_n,
    input ALI,
    output CLI,
    output DLI
);

reg [9:0] Time_Delay_r;
reg DLI_R;
reg [3:0] cnt;
reg posedge_flag;
assign DLI = DLI_R;
always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        Time_Delay_r <= 10'd0; 
    end else begin
        Time_Delay_r <= {Time_Delay_r[8:0],ALI};
    end
end

assign CLI = Time_Delay_r[9];


always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n)begin
        DLI_R <= 1'b0;
    end else if(!CLI && cnt == 4'd0) begin
        DLI_R <= 1'b1;
    end else if (ALI) begin
        DLI_R <= 1'b0;
    end
end

always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt <= 4'd0;
    end else if (cnt == 4'd10) begin
        cnt <= 4'd0;
    end else if (posedge_flag) begin
        cnt <= cnt + 4'd1;
    end
end

always @(posedge sys_clk or negedge rst_n) begin
    if (!rst_n)begin
        posedge_flag <= 1'b0;
    end else if (!CLI) begin
        posedge_flag <= 1'b1;
    end else if (cnt == 4'd0)begin
        posedge_flag <= 1'b0;
    end else begin
        posedge_flag <= posedge_flag;
    end
end



endmodule
