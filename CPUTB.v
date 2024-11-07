`timescale 1ns/1ns

module CPU_tb;

    // Declaración de señales
    reg [31:0] PC;
    wire [31:0] instruction;
    wire RegDst, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite;
    wire [2:0] ALUOp;
    wire [4:0] WriteReg;
    wire [31:0] ReadData1, ReadData2, SignExtImm, ShiftLeftImm, ALUResult, MemData, WriteData;
    wire Zero;

    // Instancia del módulo CPU
    CPU cpu (
        .PC(PC),
        .instruction(instruction),
        .RegDst(RegDst),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemToReg(MemToReg),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .ALUOp(ALUOp),
        .WriteReg(WriteReg),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .SignExtImm(SignExtImm),
        .ShiftLeftImm(ShiftLeftImm),
        .ALUResult(ALUResult),
        .MemData(MemData),
        .WriteData(WriteData),
        .Zero(Zero)
    );

    // Ciclo de reloj y estímulos
    initial begin
        // Inicialización
        PC = 32'd0;

        // Ciclo de prueba
        #10;
        PC = 32'd4;
        #10;
        PC = 32'd8;
        #10;
        PC = 32'd12;
        #10;

        // Finaliza la simulación
        $finish;
    end

    // Monitor de las señales
    initial begin
        $monitor("PC=%d, instruction=%b, ALUResult=%d", PC, instruction, ALUResult);
    end

endmodule

