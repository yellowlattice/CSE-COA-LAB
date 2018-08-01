`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:02:42 03/07/2018 
// Design Name: 
// Module Name:    AluCtr 
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
module AluCtr(aluOp, funct, aluCtr);
    input [1:0] aluOp;
    input [5:0] funct;
    output [3:0] aluCtr;
    
	 reg [3:0] aluCtr;
	 
	 always @ (aluOp or funct)
	 casex ({aluOp, funct})
		8'b00xxxxxx: aluCtr = 4'b0010; //lw sw
		8'b01xxxxxx: aluCtr = 4'b0110; //beq
		8'b10100000: aluCtr = 4'b0010; //add
		8'b10100010: aluCtr = 4'b0110; //sub
		8'b10100100: aluCtr = 4'b0000; //and
		8'b10100101: aluCtr = 4'b0001; //or
		8'b10101010: aluCtr = 4'b0111; //stl
    endcase


endmodule
