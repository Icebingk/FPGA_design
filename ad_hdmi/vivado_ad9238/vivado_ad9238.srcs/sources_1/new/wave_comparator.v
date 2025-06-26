module wave_comparator(
input iCLK_tri,
input iCLK_sin,
input iRST_n,//
output oComparator
);
    wire [11:0] Read_tri_data,Read_sin_data;
    reg [7:0]   Read_tri_addr;
    reg [15:0]   Read_sin_addr;
    
    always@(posedge iCLK_tri or negedge iRST_n )
    begin
    if(!iRST_n)
    Read_tri_addr<=0;//addr=0 data=?
    else if(Read_tri_addr==7'd99)//99 or 100?
    Read_tri_addr<=0;
    else
    Read_tri_addr<=Read_tri_addr+1;
    end
    
    always@(posedge iCLK_sin or negedge iRST_n )
    begin
    if(!iRST_n)
    Read_sin_addr<=0;
    else if(Read_sin_addr==15'd999)
    Read_sin_addr<=0;
    else
    Read_sin_addr<=Read_sin_addr+1;
    end
       
    rom_tri rom_ip1 
    (
    .clka(iCLK_tri),
    .addra(Read_tri_addr),
    .douta(Read_tri_data)
    );
    
    rom_sin rom_ip2 
    (
    .clka(iCLK_sin),
    .addra(Read_sin_addr),
    .douta(Read_sin_data)
    );    
    assign oComparator=(Read_tri_data<Read_sin_data)?1:0;
    
endmodule

