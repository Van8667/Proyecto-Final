`timescale 1ns/1ns

module ALUControl(
    input [1:0] ALUOp,
    input [5:0] FuncCode,
    output reg [2:0] ALUControlOut
);

    always @(*) begin
        case(ALUOp)
            2'b00: ALUControlOut = 3'b010; // ADD
            2'b01: ALUControlOut = 3'b110; // SUB
            2'b10: begin
                case(FuncCode)
                    6'b100000: ALUControlOut = 3'b010; // ADD
                    6'b100010: ALUControlOut = 3'b110; // SUB
                    6'b100100: ALUControlOut = 3'b000; // AND
                    6'b100101: ALUControlOut = 3'b001; // OR
                    6'b101010: ALUControlOut = 3'b111; // SLT
                    default: ALUControlOut = 3'b000;
                endcase
            end
            default: ALUControlOut = 3'b000;
        endcase
    end
endmodule

