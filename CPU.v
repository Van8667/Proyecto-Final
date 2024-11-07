`timescale 1ns/1ns

module CPU(
    input [31:0] PC,                     // Contador de programa
    output [31:0] instruction,           // Instrucción de la memoria
    output RegDst, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite,
    output [2:0] ALUOp,
    output [4:0] WriteReg,
    output [31:0] ReadData1, ReadData2, SignExtImm, ShiftLeftImm, ALUResult, MemData, WriteData,
    output Zero
);
    // Instancia de la Memoria de Instrucciones
    IM instruction_memory (
        .RA(PC),
        .instruccion(instruction)
    );

    // Unidad de Control
    Control control_unit (
        .opcode(instruction[31:26]),
        .RegDst(RegDst),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemToReg(MemToReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite)
    );

    // Extensión de Signo
    SignExtend sign_extend (
        .in(instruction[15:0]),
        .out(SignExtImm)
    );

    // Shift Left (desplazamiento de bits a la izquierda)
    ShiftLeft shift_left (
        .out(SignExtImm),
        .outALU(ShiftLeftImm)
    );

    // MUX para seleccionar el registro destino
    mux2_1_5bit reg_dst_mux (
        .sel(RegDst),
        .A(instruction[20:16]),
        .B(instruction[15:11]),
        .C(WriteReg)
    );

    // Conjunto de Registros
    Registers register_file (
        .ReadReg1(instruction[25:21]),
        .ReadReg2(instruction[20:16]),
        .WriteReg(WriteReg),
        .WriteData(WriteData),
        .RegWrite(RegWrite),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    // MUX para seleccionar el segundo operando de la ALU
    wire [31:0] ALUInput2;
    mux2_1 alu_src_mux (
        .sel(ALUSrc),
        .A(ReadData2),
        .B(SignExtImm),
        .C(ALUInput2)
    );

    // Control de la ALU
    ALUControl alu_control (
        .ALUOp(ALUOp[1:0]),
        .FuncCode(instruction[5:0]),
        .ALUControlOut(ALUOp)
    );

    // ALU
    ALU alu (
        .Ope1(ReadData1),
        .Ope2(ALUInput2),
        .AluOp(ALUOp),
        .Resultado(ALUResult)
    );

    // Memoria de Datos
    DataMemory data_memory (
        .Address(ALUResult),
        .WriteData(ReadData2),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ReadData(MemData)
    );

    // MUX para seleccionar el dato a escribir en el registro
    mux2_1 mem_to_reg_mux (
        .sel(MemToReg),
        .A(ALUResult),
        .B(MemData),
        .C(WriteData)
    );

    // Adición para calcular el PC
    wire [31:0] PCPlus4, BranchTarget;
    ADD add_pc_plus4 (
        .PC(PC),
        .bits(32'd4),
        .suma(PCPlus4)
    );

    ADD add_branch (
        .PC(PCPlus4),
        .bits(ShiftLeftImm),
        .suma(BranchTarget)
    );

    // MUX para decidir si hacer branch
    wire PCSrc = Branch & Zero;
    mux2_1 pc_mux (
        .sel(PCSrc),
        .A(PCPlus4),
        .B(BranchTarget),
        .C(PC)
    );

endmodule
