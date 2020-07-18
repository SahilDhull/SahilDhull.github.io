`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:53:19 02/05/2018 
// Design Name: 
// Module Name:    ripple 
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

module ripple(clk,l0,l1,l2,l3,l4,l5,l6,l7);

input clk;
output l0;
reg l0;
output l1;
reg l1;
output l2;
reg l2;
output l3;
reg l3;
output l4;
reg l4;
output l5;
reg l5;
output l6;
reg l6;
output l7;
reg l7;

reg [26:0]counter;
initial counter=27'b0;

initial l0=1'b1;
initial l1=1'b0;
initial l2=1'b0;
initial l3=1'b0;
initial l4=1'b0;
initial l5=1'b0;
initial l6=1'b0;
initial l7=1'b0;

always@(posedge clk) begin
counter<=counter+1;
if (counter==50000000) begin
l1<=l0;
l2<=l1;
l3<=l2;
l4<=l3;
l5<=l4;
l6<=l5;
l7<=l6;
l0<=l7;
counter<=0;
end
end
endmodule