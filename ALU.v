`timescale 1ns/1ns

module ALU(
    input [31:0] Ope1,
	input [31:0] Ope2,
    input [2:0] AluOp,
    output reg [31:0] Resultado,
	output reg ZeroFlag
);

always @(*)
begin
	case (AluOp)
		3'b000: //AND
		begin
			Resultado = Ope1 & Ope2;
		end
		3'b001: //OR
		begin
			Resultado = Ope1 | Ope2;
		end
		3'b010: //ADD
		begin
			Resultado = Ope1 + Ope2; 
		end
		3'b110: //SUB
		begin
			Resultado = Ope1 - Ope2;
		end
		3'b111: //SLT
		begin
			Resultado = (Ope1 < Ope2) ? 32'b1 : 32'b0;
		end
		3'b100: //NOR
		begin
			Resultado = ~(Ope1 | Ope2);
		end
		3'b101: //XOR
		begin
			Resultado = Ope1 ^ Ope2;
		end
		default: 
		begin
			Resultado = 32'b0;
		end
	endcase
	
	ZeroFlag = (Resultado == 32'b0) ? 1'b1 : 1'b0;
end

endmodule
