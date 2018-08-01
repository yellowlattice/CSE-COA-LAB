`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:39:30 03/14/2018 
// Design Name: 
// Module Name:    Top 
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
module top(clk,reset);
	input clk;
	input reset;
	reg [31:0] PC;

	wire	[31:0]regFile[31:0];
	wire 	REG_DST,JUMP,BRANCH,MEM_READ,MEM_TO_REG,MEM_WRITE;
	wire 	[1:0] ALU_OP;
	wire 	ALU_SRC,
			REG_WRITE;
	wire 	[31:0] READ_DATA1;
	wire	[31:0] READ_DATA2;
	wire	[31:0] ALU_RES;
	wire	ZERO;
	wire	[31:0] READ_DATA;
	wire	[3:0] ALU_CTR;
	wire	[31:0] INST;
	wire	[31:0] SIGN_EXT;
	wire	[4:0] REG_MUX;
	wire	[31:0] ALU_MUX;
	wire	[31:0] MEM_MUX;
	wire	[31:0] BRANCH_MUX;
	wire	[31:0] JUMP_MUX;
	wire	[31:0] PC_PLUS_FOUR;
	wire	[31:0] BRANCH_ADDR;
	wire	[31:0] JUMP_ADDR;

	Ctr mainCtr(
		.opCode(INST[31:26]),
		.regDst(REG_DST),
		.aluSrc(ALU_SRC),
		.memToReg(MEM_TO_REG),
		.regWrite(REG_WRITE),
		.memRead(MEM_READ),
		.memWrite(MEM_WRITE),
		.branch(BRANCH),
		.aluOp(ALU_OP),
		.jump(JUMP));
		
	Alu mainAlu(
		.input1(READ_DATA1), 
		.input2(ALU_MUX), 
		.aluCtr(ALU_CTR), 
		.zero(ZERO), 
		.aluRes(ALU_RES));
		
	AluCtr mainAluCtr(
		.aluOp(ALU_OP), 
		.funct(INST[5:0]), 
		.aluCtr(ALU_CTR));
		
	register mainRegister(
		.clock_in(clk),
		.readReg1(INST[25:21]),
		.readReg2(INST[20:16]),
		.writeReg(REG_MUX),
		.writeData(MEM_MUX),
		.regWrite(REG_WRITE),
		.readData1(READ_DATA1),
		.readData2(READ_DATA2),
		.reset(reset));
		
	data_memory mainDataMemory(
		.clock_in(clk),
		.address(ALU_RES),
		.writeData(READ_DATA2),
		.memWrite(MEM_WRITE),
		.memRead(MEM_READ),
		.readData(READ_DATA),
		.reset(reset));
	
	signext mainSignExt(
		.inst(INST[15:0]),
		.data(SIGN_EXT));
	
	ins_memory mainInsMemory(
		.address(PC),
		.ins(INST),
		.reset(reset));

		
	assign REG_MUX = REG_DST ? INST[15:11] : INST[20:16];
	assign ALU_MUX = ALU_SRC ? SIGN_EXT : READ_DATA2;
	assign MEM_MUX = MEM_TO_REG ? READ_DATA : ALU_RES;
	assign PC_PLUS_FOUR = PC + 4;
	assign JUMP_ADDR = {PC_PLUS_FOUR[31:26],INST[25:0]<<2};
	assign BRANCH_MUX = (BRANCH & ZERO) ? (PC_PLUS_FOUR + (SIGN_EXT<<2)) : PC_PLUS_FOUR;
	assign JUMP_MUX = JUMP ? JUMP_ADDR : BRANCH_MUX;
			
	always @(posedge clk)
	begin
		PC <= JUMP_MUX;
		if (reset == 1)
		begin
			PC <= 0;
		end
	end	
	
endmodule
