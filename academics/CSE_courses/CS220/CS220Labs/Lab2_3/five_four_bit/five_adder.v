`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:42:11 01/31/2018 
// Design Name: 
// Module Name:    five_adder 
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
module five_adder(a,b,sum);
input [4:0]a;
input [4:0]b;
output [5:0]sum;
wire [5:0]sum;
wire [3:0]carry;

full_adder FA20 (a[0],b[0],1'b0,sum[0],carry[0]);
full_adder FA21 (a[1],b[1],carry[0],sum[1],carry[1]);
full_adder FA22 (a[2],b[2],carry[1],sum[2],carry[2]);
full_adder FA23 (a[3],b[3],carry[2],sum[3],carry[3]);
full_adder FA24 (a[4],b[4],carry[3],sum[4],sum[5]);



endmodule
