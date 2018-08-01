`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:11:33 03/14/2018 
// Design Name: 
// Module Name:    register 
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
module register(clock_in,readReg1,readReg2,writeReg,writeData,regWrite,readData1,readData2,reset);

    input clock_in;
    input [4:0] readReg1;
    input [4:0] readReg2;
    input [4:0] writeReg;
    input [31:0] writeData;
    input regWrite;
    output [31:0] readData1;
    output [31:0] readData2;
	 input reset;
	 
	 reg [31:0] regFile[31:0];
	 reg [31:0] readData1;
	 reg [31:0] readData2;
	 integer i;

	 always @(readReg1 or readReg2)
	 begin
		readData1 = regFile[readReg1];
		readData2 = regFile[readReg2];
    end
	 
	 always @(negedge clock_in)
	 begin
		if (regWrite == 1)
			regFile[writeReg] <= writeData;
		if (reset == 1)
			for(i=0;i<32;i=i+1)
			begin
				regFile[i] <= 0;
			end
    end
	 
endmodule
