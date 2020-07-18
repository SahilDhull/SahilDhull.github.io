`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:32:52 01/31/2018 
// Design Name: 
// Module Name:    four_adder 
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
module four_adder(a,b,sum);
input [3:0]a;
input [3:0]b;
output [4:0]sum;
wire [4:0]sum;
wire [2:0]carry;

full_adder FA0 (a[0],b[0],1'b0,sum[0],carry[0]);
full_adder FA1 (a[1],b[1],carry[0],sum[1],carry[1]);
full_adder FA2 (a[2],b[2],carry[1],sum[2],carry[2]);
full_adder FA3 (a[3],b[3],carry[2],sum[3],sum[4]);



endmodule
