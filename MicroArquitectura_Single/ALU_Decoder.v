module ALU_Decoder (
    input [1:0] ALUOp,
    input [2:0] funct3,
    input op, 
    input funct7, 
    output reg [2:0] ALUCtrl
);

always @ (*)
    case (ALUOp)
        2'b00: 
            ALUCtrl= 3'b000;   

        2'b01:   
            ALUCtrl= 3'b001;   

        2'b10:  
        begin 
            case (funct3)
            3'b000: 
                if ({op,funct7}== 2'b11)
                    ALUCtrl= 3'b001;   
                else 
                    ALUCtrl= 3'b000;

            3'b010:
                ALUCtrl= 3'b101;   

            3'b110:
                ALUCtrl= 3'b011; 
            
            3'b111:
                ALUCtrl= 3'b010;  

            default: 
                ALUCtrl= 3'bxxx;

            endcase 
        end

        default:
            ALUCtrl= 3'bxxx;
    endcase 
endmodule 