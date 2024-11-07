`timescale 1ns/1ns 

module ADD(
    input [31:0] PC,
    input [31:0] bits,
    output reg [31:0] suma
); 

    always @(*) begin
        suma = PC + bits;
    end

endmodule
