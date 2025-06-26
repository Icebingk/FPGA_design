module wave(
input iSys_clk,
input iRst_n,
output ALI,
output oSin_clk_out
    );
    wire oTri_clk;
    wire oSin_clk;
    assign oSin_clk_out = oSin_clk;
    wave_clk wave_clk
    (
    . iSys_clk(iSys_clk),
    . iRst_n(iRst_n),
    .  oTri_clk(oTri_clk),
    .  oSin_clk(oSin_clk)
    );
    wave_comparator wave_comparator
    (
    . iCLK_tri(oTri_clk),
    . iCLK_sin(oSin_clk),
    . iRST_n(iRst_n),//
    . oComparator(ALI)
    
    );
   
 /*  ila ILA
   (
   .clk(iSys_clk),
   
   
   .probe0(iSys_clk),
   .probe1(oTri_clk),
   .probe2(oSin_clk),
   .probe3(iRst_n),
   .probe4(ALI)
   

   );
   */
endmodule

