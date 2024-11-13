`timescale 1ns/1ns

module Banco(
    input [4:0]DL1,
    input [4:0]DL2,
    input [4:0]DE,
    input [31:0]Dato,
    input WE,
    output reg[31:0]op1,
    output reg[31:0]op2
);

reg [31:0] BR [31:0];

always @*
begin
	op1 = BR[DL1];
    op2 = BR[DL2];
end
	
always @(posedge WE)
begin
	if (WE)
        BR[DE] <= Dato;
end

endmodule 

