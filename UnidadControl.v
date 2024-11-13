`timescale 1ns/1ns

module U_Control(
    input [5:0] OpCode,
    output reg BR_En,
    output reg [2:0] AluC,
    output reg EnW,
    output reg EnR,
    output reg Mux1
);

    always @(*) begin
        case(OpCode)
            6'b000000: begin // Tipo R
                BR_En = 1'b1;
                AluC = 3'b000;
                EnW = 1'b0;
                EnR = 1'b0;
                Mux1 = 1'b1;
            end
            6'b001000: begin // ADDI (suma inmediata)
                BR_En = 1'b1;
                EnW = 1'b0;
                EnR = 1'b0;
                Mux1 = 1'b1;
            end
            default: begin
                BR_En = 1'b0;
                EnW = 1'b0;
                EnR = 1'b0;
                Mux1 = 1'b0;
            end
        endcase
    end
endmodule
