`timescale 1ns/1ns

module Registers(
    input [4:0] ReadReg1,
    input [4:0] ReadReg2,
    input [4:0] WriteReg,
    input [31:0] WriteData,
    input RegWrite,
    output [31:0] ReadData1,
    output [31:0] ReadData2
);

    reg [31:0] registerFile[31:0];

    initial begin
        registerFile[0] = 0; // El registro 0 siempre es 0
    end

    assign ReadData1 = registerFile[ReadReg1];
    assign ReadData2 = registerFile[ReadReg2];

    always @(posedge RegWrite) begin
        if (RegWrite) registerFile[WriteReg] <= WriteData;
    end
endmodule
