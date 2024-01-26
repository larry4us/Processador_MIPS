`timescale 1ns / 1ps
`define BITSIZE 32
////////////////////////////////////////////////////////////////////////////////
// FTL065 - Arquitetura de Sistemas Digitais
// Laboratório 2
// Alunos:
// - Pedro Larry Rodrigues Lopes - 22153167. 
// - Gabriel Toshiyuki Batista Toyoda - 22153164.
//
// ENTRADAS:-
// ReadRegister1: Endereço de 5 bits para selecionar um registrador a ser lido pelo
//                porto de saida de 32 bits 'ReadData1'.
// ReadRegister2: Endereço de 5 bits para selecionar um registrador a ser lido pelo
//                porto de saida de 32 bits 'ReadData2'.
// WriteRegister: Endereço de 5 bits para selecionar um registrador a ser escrito pelo
//                porto de entrada de 32 bits 'WriteData'.
// WriteData: Entrada de escrita de 32 bits.
// RegWrite: Sinal de controle de 1 bit.
// Clk: Sinal de clock.
//
// SAIDAS:-
// ReadData1: Saida registrada de 32 bits.
// ReadData2: Saida registrada de 32 bits.
//
////////////////////////////////////////////////////////////////////////////////


module Registrador(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2);
	parameter BITS_SIZE = `BITSIZE;
	parameter TOP_MEM_ADDRESS = 32'd252;

	// Declaracao das variaveis de input
	input [4:0] ReadRegister1,ReadRegister2,WriteRegister;
	input [BITS_SIZE - 1:0] WriteData;
	input RegWrite,Clk;
	
	// Declaracao dos registradores de saida
	output reg [BITS_SIZE - 1:0] ReadData1,ReadData2;
	
	reg [BITS_SIZE - 1:0] Registers [0:BITS_SIZE - 1];
	
	// Inicializacao da matriz dos 32 registradores.
	initial begin
		Registers[0] <= 32'h00000000;
		Registers[8] <= 32'h00000000;
		Registers[9] <= 32'h00000000;
		Registers[10] <= 32'h00000000;
		Registers[11] <= 32'h00000000;
		Registers[12] <= 32'h00000000;
		Registers[13] <= 32'h00000000;
		Registers[14] <= 32'h00000000;
		Registers[15] <= 32'h00000000;
		Registers[16] <= 32'h00000000;
		Registers[17] <= 32'h00000000;
		Registers[18] <= 32'h00000000;
		Registers[19] <= 32'h00000000;
		Registers[20] <= 32'h00000000;
		Registers[21] <= 32'h00000000;
		Registers[22] <= 32'h00000000;
		Registers[23] <= 32'h00000000;
		Registers[24] <= 32'h00000000;
		Registers[25] <= 32'h00000000;
		Registers[29] <= TOP_MEM_ADDRESS; // valor que deve apontar pro topo dos dados de memória
		Registers[31] <= 32'b0;
	end
	
	// Sempre na subida do clock
	always @(posedge Clk)
	// Bloco procedural
	begin
		// Caso o RegWrite esteja ativo, o registrador escolhido por WriteRegister recebe o WriteData.
		if (RegWrite == 1) 
		begin
			Registers[WriteRegister] <= WriteData;
		end
	end
	// Sempre na descida do clock
	always @(negedge Clk)
	// Bloco procedural
	begin
		// Os outputs recebem os registradores selecionados por ReadRegister
		ReadData1 <= Registers[ReadRegister1];
		ReadData2 <= Registers[ReadRegister2];
	end	

endmodule