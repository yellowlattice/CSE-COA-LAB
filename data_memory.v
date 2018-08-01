`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:16:54 03/14/2018 
// Design Name: 
// Module Name:    data_memory 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module data_memory(clock_in,address,writeData,memWrite,memRead,readData,reset);
    input clock_in;
    input [31:0] address;
    input [31:0] writeData;
    input memWrite;
    input memRead;
	 input reset;
    output [31:0] readData;
	 
	 reg [31:0] memFile[0:127];
	 reg [31:0] readData;
	 
	 initial begin
		$readmemh("./Src/mem_data.txt", memFile, 10'h0);
	 end

	 always @(address or memRead)
	 begin
		if (memRead == 1)
			readData = memFile[address>>2];
    end
	 
	 always @(negedge clock_in)
	 begin
		if (memWrite == 1)
			memFile[address>>2] <= writeData;
    end
	 
endmodule
