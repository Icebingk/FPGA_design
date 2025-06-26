module wave_clk(
    input iSys_clk,
    input iRst_n,
    output  oTri_clk,
    output  oSin_clk
);
    wire locked;
    wire locked_1;
    wire clk_temp;
    reg [6:0] cnt;
    reg oSin_clk_10DIv = 1'b0;
    assign oSin_clk = oSin_clk_10DIv;
    always @(posedge clk_temp) begin
        if (!iRst_n)begin
            oSin_clk_10DIv = 1'b0;
        end else if(cnt==7'd0) begin
            oSin_clk_10DIv = ~oSin_clk_10DIv;
        end
    end
    clk_wiz_1 clk_generator_sin
     (
      // Clock out ports
      .clk_out2(oTri_clk),
      .clk_out1(clk_temp),     // output clk_out1
      // Status and control signals
      .reset(~iRst_n), // input reset
      .locked(locked),       // output locked
     // Clock in ports
      .clk_in1(iSys_clk)
      );     

    always @(posedge clk_temp) begin
        if (!iRst_n) begin
            cnt <= 7'd0;
        end else if (cnt == 7'd49) begin
            cnt <= 7'd0;
        end else begin
            cnt <= cnt + 7'b1;
        end
    end

endmodule
