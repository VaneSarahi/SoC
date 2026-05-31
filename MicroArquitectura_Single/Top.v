module top (
    input clk,
    input reset
);

    wire [31:0] PCNext;
    wire [31:0] PC_out;
    wire [31:0] PCPlus4;
    wire [31:0] PCTarget;
    wire [31:0] Instr;

    wire RegWrite;
    wire [1:0] ImmSrc;
    wire ALUSrc;
    wire MemWrite;
    wire [1:0] ResultSrc;
    wire Branch;
    wire Jump;
    wire [2:0] ALUCtrl;

    wire [31:0] Result;
    wire [31:0] RD1, RD2;
    wire [31:0] ImmExt;
    wire [31:0] SrcB;
    wire [31:0] ALUResult;
    wire [31:0] ReadData;
    wire Zero;

    wire PCSrc;
    assign PCSrc = (Branch && Zero) || Jump;


    MUX_par #(.N(2)) pcmux (
        .mux_in({PCTarget, PCPlus4}),
        .mux_sel(PCSrc),
        .mux_out(PCNext)
    );

    PC pc_reg (
        .clk(clk),
        .reset(reset),
        .PCNext(PCNext),
        .PC(PC_out)
    );

    IM instruction_mem (
        .A(PC_out),
        .RD(Instr)
    );

    Adder pc_adder_4 (
        .A(PC_out),
        .B(32'd4),
        .Y(PCPlus4)
    );

    CU control_unit (
        .op(Instr[6:0]),
        .funct3(Instr[14:12]),
        .funct7(Instr[30]),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .Jump(Jump),
        .ALUCtrl(ALUCtrl)
    );

    RF register_file (
        .clk(clk),
        .A1(Instr[19:15]),
        .A2(Instr[24:20]),
        .A3(Instr[11:7]),
        .WD3(Result),
        .WE3(RegWrite),
        .RD1(RD1),
        .RD2(RD2)
    );

    Immediate imm_ext (
        .Imm_in(Instr),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt)
    );

    Adder pc_adder_target (
        .A(PC_out),
        .B(ImmExt),
        .Y(PCTarget)
    );

    MUX_par #(.N(2)) alumux (
        .mux_in({ImmExt, RD2}),
        .mux_sel(ALUSrc),
        .mux_out(SrcB)
    );

    ALU alu (
        .a(RD1),
        .b(SrcB),
        .aluCtrl(ALUCtrl),
        .flag(Zero),
        .result(ALUResult)
    );

    DM data_mem (
        .clk(clk),
        .A(ALUResult),
        .WE(MemWrite),      
        .WD(RD2),
        .ReadData(ReadData)
    );

    MUX_par #(.N(3)) resultmux (
        .mux_in({PCPlus4, ReadData, ALUResult}),
        .mux_sel(ResultSrc),
        .mux_out(Result)
    );

endmodule
