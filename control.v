`timescale 1ns/1ns

module Control(
    input [5:0] opcode,
    output reg RegDst,
    output reg Branch,
    output reg MemRead,
    output reg MemToReg,
    output reg [2:0] ALUOp,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite
);

    always @(*) begin
        case(opcode)
            6'b000000: begin // Tipo R
                RegDst = 1;
                ALUSrc = 0;
                MemToReg = 0;
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 3'b010;
            end
            // Agregar otros casos para LW, SW, BEQ, etc.
            default: begin
                RegDst = 0;
                ALUSrc = 0;
                MemToReg = 0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 3'b000;
            end
        endcase
    end
endmodule

