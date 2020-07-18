`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:16:06 02/12/2018 
// Design Name: 
// Module Name:    top 
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
module top(clk,r_a,r_b,led0, led1, led2, led3, led4, led5, led6, led7);
input clk, r_a, r_b;
output led0, led1, led2, led3, led4, led5, led6, led7;
wire led0, led1, led2, led3, led4, led5, led6, led7;
wire r_event,r_dir;



inp I1(clk,r_a,r_b,r_event,r_dir);
out O1(clk, r_event, r_dir,led0, led1, led2, led3, led4, led5, led6, led7);

endmodule
