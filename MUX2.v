`timescale 1ns/1ns

module mux2(
    input sel,
    input [31:0] A,
    input [31:0] B,
    output reg [31:0] C
);

always @* begin
    if (sel)
        C = B;
    else
        C = A;
end

endmodule

