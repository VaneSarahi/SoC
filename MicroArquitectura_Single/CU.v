module CU(
    input [6:0] op, 
    input [2:0] funct3,
    input funct7, 

    output reg RegWrite,
    output reg [1:0] ImmSrc, 
    output reg ALUSrc, 
    output reg MemWrite,
    output reg [1:0] ResultSrc,
    output reg Branch, 
    output reg Jump,
    output reg [2:0] ALUCtrl
);

wire [1:0] ALUOp;

mainDecoder md (
    .op(op),
    .RegWrite(RegWrite),
    .ImmSrc(ImmSrc), 
    .ALUSrc(ALUSrc), 
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .Branch(Branch, 
    .ALUOp(ALUOp),  
    .Jump(Jump)
    );

ALU_DECODER ad(
    .ALUOp(ALUOp),
    .funct3(funct3),
    .op(op[5]), 
    .funct7(funct7), 
    .ALUCtrl(ALUCtrl)
);


endmodule 