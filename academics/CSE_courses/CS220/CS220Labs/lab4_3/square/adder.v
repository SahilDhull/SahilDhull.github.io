`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:53:14 02/12/2018 
// Design Name: 
// Module Name:    adder 
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
module adder(a,b,op,cin,sum,cout);
	input a;
	input b;
	input op;
	input cin;
	wire x;
	output sum;
	wire sum;
	output cout;
	wire cout;
	assign x= b^op;
	assign sum = a^x^cin;
	assign cout = (a & x) | (x & cin) | (cin & a);
endmodule