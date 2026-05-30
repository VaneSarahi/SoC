module RF( //register file
    input clk,
    input [4:0] A1,
    input [4:0] A2, 
    input [4:0] A3, 
    input [31:0] WD3, 
    input WE3,
    output [31:0] RD1, 
    output [31:0] RD2
);

reg [31:0] REG [31:0];

assign RD1 = (A1 == 0) ? 32'b0: REG[A1];
assign RD2 = (A2 == 0) ? 32'b0: REG[A2];

always @(posedge clk)
    begin 
        if (WE3 && 1 (A3 !=0))
            REG[A3] <=WD3;
    end 

endmodule