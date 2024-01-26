`timescale 1ns / 1ps
`define BITSIZE 32

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Arquitetura de Sistemas Digitais
// Laboratório 2
//
// ENTRADAS:-
// ReadRegister1: Endereço de 5 bits para selecionar um registrador a ser lido pelo
//                porto de saída de 32 bits 'ReadRegister1'.
// ReadRegister2: Endereço de 5 bits para selecionar um registrador a ser lido pelo
//                porto de saída de 32 bits 'ReadRegister2'.
// WriteRegister: Endereço de 5 bits para selecionar um registrador a ser escrito pelo
//                porto de entrada de 32 bits 'WriteRegister'.
// WriteData: Entrada de escrita de 32 bits.
// RegWrite: Sinal de controle de 1 bit.
//
// SAÍDAS:-
// ReadData1: Saída registrada de 32 bits.
// ReadData2: Saída registrada de 32 bits.
//
// FUNCIONALIDADE:-
// 'ReadRegister1' e 'ReadRegister2' são dois endereços de 5 bits para ler dois
// registradores simultaneamente. Os dois conjuntos de dados de 32 bits estão disponíveis
// nos portos 'ReadData1' e 'ReadData2', respectivamente. 'ReadData1' e 'ReadData2' são
// saídas registradas (a saída do arquivo de registros é escrita nesses registradores
// na borda de descida do clock). Você pode entender como se as saídas dos registradores
// especificados por ReadRegister1 e ReadRegister2 fossem escritas nos registradores de
// saída ReadData1 e ReadData2 na borda de descida do clock.
//
// O sinal 'RegWrite' está alto durante a borda de subida do clock se os dados de entrada
// devem ser escritos no arquivo de registros. O conteúdo do registrador
// especificado pelo endereço 'WriteRegister' no arquivo de registros é modificado na
// borda de subida do clock se o sinal 'RegWrite' estiver alto. Os flip-flops D no arquivo
// de registros são acionados na borda de subida do clock. (Você deve usar
// essa informação para gerar corretamente o clock de escrita.)
//
// OBSERVAÇÃO:-
// Projetaremos o arquivo de registros de modo que o conteúdo dos registradores não
// mude por um tempo predefinido antes da borda de descida do clock chegar, permitindo
// tempo de multiplexação de dados e tempo de configuração.
////////////////////////////////////////////////////////////////////////////////


module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2);
	parameter BITS_SIZE = `BITSIZE;
	parameter TOP_MEM_ADDRESS = 32'd252;

	// Declaraçao das variáveis de input
	input [4:0] ReadRegister1,ReadRegister2,WriteRegister;
	input [BITS_SIZE - 1:0] WriteData;
	input RegWrite,Clk;
	
	// Declaraçao dos registradores de saida
	output reg [BITS_SIZE - 1:0] ReadData1,ReadData2;
	
	
	//reg [31:0] Registers = new reg[32];
	reg [BITS_SIZE - 1:0] Registers [0:BITS_SIZE - 1];
	
	// Inicializaçao da matriz dos 32 registradores.
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
		Registers[29] <= TOP_MEM_ADDRESS; // this value should point to the top of data memory, dont forget byte addressing
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