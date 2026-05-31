module Immediate(
    input [31:0] Imm_in,
    input [1:0] ImmSrc,
    output reg [31:0] ImmExt
);

always @(*) begin
    case(ImmSrc)

        2'b00: //i type
            ImmExt = {{20{Imm_in[31]}}, Imm_in[31:20]};

        2'b01: //s type
            ImmExt = {{20{Imm_in[31]}}, Imm_in[31:25], Imm_in[11:7]};

        2'b10: //b type
            ImmExt = {{19{Imm_in[31]}}, Imm_in[31], Imm_in[7], Imm_in[30:25], Imm_in[11:8], 1'b0};

        2'b11: //j type
            ImmExt = {{11{Imm_in[31]}}, Imm_in[31], Imm_in[19:12], Imm_in[20], Imm_in[30:21], 1'b0};

        default:
            ImmExt = 32'b0;

    endcase
end

endmodule
