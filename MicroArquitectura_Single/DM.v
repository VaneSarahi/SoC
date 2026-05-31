module DM(
    input clk, 
    input [31:0] A, 
    input WE, 
    input [31:0] WD, 
    output [31:0] ReadData
);

reg [31:0] data_mem [0:255];

assign ReadData= data_mem[A[31:2]];

always @(posedge clk)
    begin 
        if (WE)
        data_mem[A[31:2]] <=WD;
    end 

endmodule 
