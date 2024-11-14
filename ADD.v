`timescale 1ns/1ns 

module ADD(
    input [31:0] dato1,
    input [31:0] dato2,
    output [31:0] suma
); 

assign suma = dato1 + dato2;

endmodule
