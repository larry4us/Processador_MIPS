`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// FTL065 - Arquitetura de Sistemas Digitais
// Laboratório 2
// Alunos:
// - Pedro Larry Rodrigues Lopes - 22153167. 
// - Gabriel Toshiyuki Batista Toyoda - 22153164.
//
// PARAMETROS --
// BITS_SIZE: Tamanho dos numeros sobre os quais serão realiadas as operacoes.
//
// ENTRADAS --
// A: Entrada de 32 bits (parametrizada) para a ALU.
// B: Entrada de 32 bits (parametrizada) para a ALU.
// ALUControl: Entrada de seleção de 4 bits para determinar a operação da ALU.
//
// SAIDAS --
// ALUResult: Saída de 32 bits (parametrizada) representando o resultado da operação da ALU.
// Zero: Saída de 1 bit indicando se ALUResult é zero ou não.
//
// Baseado no trabalho de Caskman.
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit #(parameter BITS_SIZE = 32)(ALUControl, A, B, ALUResult, Zero);

	input   [3:0]   ALUControl; // bits de controle para ALU
	input   [BITS_SIZE - 1:0]  A, B;	    // inputs

	integer temp,i,x;
	reg [BITS_SIZE - 1:0] y;
	reg sign;
	
	output  reg [BITS_SIZE - 1:0]  ALUResult;	// resultado
	output  reg     Zero;	    // Zero=1 se ALUResult == 0

    always @(ALUControl,A,B)
    begin
		case (ALUControl)
			0: // AND
				ALUResult <= A & B;
			1: // OR
				ALUResult <= A | B;
			2: // ADD
				ALUResult <= A + B;
			6: // SUB
				ALUResult <= A + (~B + 1);
			7: begin // SLT
				ALUResult <= A < B ? 1:0;
			end
			12: // NOR
				if (A | B == 1) begin
					ALUResult <= 0;
				end else begin
					ALUResult <= 1;
				end
			default: ALUResult <= 0;
		endcase
	end


	always @(ALUResult) begin
		if (ALUResult == 0) begin
			Zero <= 1;
		end else begin
			Zero <= 0;
		end
	
	end

endmodule