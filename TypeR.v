`timescale 1ns/1ns

module TypeR(
    input [31:0]instruccion,
    output [31:0] Resultado
);

//Banco de Registros
wire [31:0] d1BR_op1ALu;
wire [31:0] d1BR_op2ALu;

//cables Mux1
wire [31:0] DatoMem2BR;

//Cables ALU
wire [31:0] ResALU;

//cables unidad de control

wire BR_enabler;
wire [2:0]AluControl;
wire MemW;
wire MemR;
wire Mem_To_BR;

//Cables Mem
wire [31:0] MemD;

//Instancia de Unidad de Control
U_Control UC (
    .OpCode(instruccion[31:26]),
    .BR_En(BR_enabler),
    .AluC(AluControl),
    .EnW(MemW),
    .EnR(MemR),
    .Mux1(Mem_To_BR)
);

//Instancia de Banco de Registros
Banco instBanco (
    .DL1(instruccion [25:21]), //Rs
    .DL2(instruccion [20:16]), //Rt
    .DE(instruccion [15:11]), //Rd
    .Dato(DatoMem2BR),
    .WE(BR_enabler),
    .op1(d1BR_op1ALu),
    .op2(d1BR_op2ALu)
);

//Instancia de la ALU
ALU instALU(
    .Ope1(d1BR_op1ALu),
    .Ope2(d1BR_op2ALu),
    .AluOp(AluControl),
    .Resultado(ResALU),
	.ZeroFlag()
);

//Instancia del MUX2
mux2 mux1(
    .sel(Mem_To_BR),
    .A(MemD),
    .B(ResALU),
    .C(DatoMem2BR)
);

assign Resultado = ResALU;

endmodule

//instruccion ADD $7, $1, $2
//   OP     Rs     Rt   Rd   Shamt   Fnc 
// 000000_00001_00010_00111_00000_100000
/*
0 11
1 2023      *
2 54        *
3 900
4 510
5 50
6 101011
7 200          [2077=2023+54]
*/
