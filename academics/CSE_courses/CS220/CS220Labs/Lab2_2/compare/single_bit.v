`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:21:47 02/05/2018 
// Design Name: 
// Module Name:    single_bit 
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


module single_bit(a,b,l1,g1,e1,l2,g2,e2);

input a;
input b;
input l1;
input g1;
input e1;

output l2;
wire l2;
output g2;
wire g2;
output e2;
wire e2;

assign g2=(g1|((~l1 & b & ~a) & e1 ));
assign l2=(l1|((~g1 & ~b & a) & e1 ));
assign e2=(e1 & ((a & b )|(~a & ~b)));

endmodule