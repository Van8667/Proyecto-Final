`timescale 1ns/1ns

module TypeR_tb;

reg [31:0] instruccion; // Registro para la instrucción de entrada
wire [31:0] resultado;  // Salida del resultado de la ALU para comprobación

// Instancia del módulo TypeR
TypeR dut (
    .instruccion(instruccion),
    .resultado(resultado)
);

initial begin
    // Inicialización de la instrucción ADD $7, $1, $2
    // Formato de la instrucción R: opcode(6) - Rs(5) - Rt(5) - Rd(5) - Shamt(5) - funct(6)
    // Esta instrucción representa: opcode(000000) Rs($1) Rt($2) Rd($7) shamt(00000) funct(100000)
    instruccion = 32'b000000_00001_00010_00111_00000_100000; // ADD $7, $1, $2
    
    #10;

    // Verificación del resultado esperado
    if (resultado == 32'd2077) begin
        $display("Test exitoso: Resultado esperado en $7 = %d", resultado);
    end else begin
        $display("Test fallido: Resultado en $7 = %d, valor esperado = 2077", resultado);
    end

    #10;
    $finish;
end

initial begin
    // Monitoreo del banco de pruebas
    $monitor("Tiempo: %0t | Instrucción: %b | Resultado: %d", 
              $time, instruccion, resultado);
end

endmodule
