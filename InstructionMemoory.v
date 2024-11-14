`timescale 1ns/1ns 
module IM(
    input [31:0] RA,
    output reg [31:0] instruccion
); 

reg [7:0] MEMORIA [0:31];

initial 
    $readmemb("MEMin.txt", MEMORIA);

always @(RA) begin 
    instruccion = {MEMORIA[RA], MEMORIA[RA + 1], MEMORIA[RA + 2], MEMORIA[RA + 3]};
end
endmodule
