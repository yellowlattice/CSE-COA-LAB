`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:32:18 03/14/2018 
// Design Name: 
// Module Name:    ins_memory 
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
module ins_memory(address,ins,reset);
    input [31:0] address;
	 input reset;
    output [31:0] ins;
    
	 reg [31:0] ins;
    reg [31:0] InstMemFile[0:127];
	 initial begin
		$readmemb("./Src/mem_inst.txt", InstMemFile, 8'h0);
	 end
	 always @ (address)
	 begin
		ins = InstMemFile[address>>2];
    end
endmodule
