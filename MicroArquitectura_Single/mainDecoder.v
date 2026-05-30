module mainDecoder(
    input [6:0] op, 
    output reg RegWrite,
    output reg [1:0] ImmSrc, 
    output reg ALUSrc, 
    output reg MemWrite,
    output reg [1:0] ResultSrc,
    output reg Branch, 
    output reg [1:0] ALUOp,  
    output reg Jump
);


always@ (*) begin
    case(op)
        7'b0000011: begin //lw
            RegWrite= 1'b1; 
            ImmSrc= 2'b00;
            ALUSrc= 1'b1;
            MemWrite= 1'b0;
            ResultSrc= 1'b1;
            Branch= 1'b0;
            ALUOp= 2'b00;
            Jump= 1'b0;
        end

        7'b0100011: begin //sw
            RegWrite= 1'b1; 
            ImmSrc= 2'b01;
            ALUSrc= 1'b1;
            MemWrite= 1'b1;
            ResultSrc= 1'bx;
            Branch= 1'b0;
            ALUOp= 2'b00;
            Jump= 1'b0;
        end 
             
        7'b0110011: begin //R-type
            RegWrite= 1'b1; 
            ImmSrc= 2'bxx;
            ALUSrc= 1'b0;
            MemWrite= 1'b0;
            ResultSrc= 1'b0;
            Branch= 1'b0;
            ALUOp= 2'b10;
            Jump= 1'b0;
        end   
            
        7'b1100011: begin //beq
            RegWrite= 1'b0; 
            ImmSrc= 2'b10;
            ALUSrc= 1'b0;
            MemWrite= 1'b0;
            ResultSrc= 1'bx;
            Branch= 1'b1;
            ALUOp= 2'b01;
            Jump= 1'b0;
        end
 
        7'b0010011: begin //I-type
            RegWrite= 1'b1; 
            ImmSrc= 2'b00;
            ALUSrc= 1'b1;
            MemWrite= 1'b0;
            ResultSrc= 2'b00;
            Branch= 1'b0;
            ALUOp= 2'b10;
            Jump= 1'b0;
        end 

        7'b1101111: begin //jal
            RegWrite= 1'b1; 
            ImmSrc= 2'b11;
            ALUSrc= 1'bx;
            MemWrite= 1'b0;
            ResultSrc= 2'b10;
            Branch= 1'b0;
            ALUOp= 2'bx;
            Jump= 1'b1;
        end 

        default: begin 
            RegWrite= 1'b1; 
            ImmSrc= 2'b11;
            ALUSrc= 1'bx;
            MemWrite= 1'b0;
            ResultSrc= 2'b10;
            Branch= 1'b0;
            ALUOp= 2'bx;
            Jump= 1'b1;
        end 
    endcase 
end 
endmodule 