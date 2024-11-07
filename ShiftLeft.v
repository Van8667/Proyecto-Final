`timescale 1ns/1ns 

module ShiftLeft(
    input [31:0] out,
    output reg [31:0] outALU
);

    always @(*) begin
        outALU = out << 2;
    end

endmodule
