`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:03:50 03/05/2018 
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

module top(clk,led_e,led_rs,led_w,data);

input clk;

output wire led_e,led_rs,led_w;
output wire [3:0]data;
wire [127:0]line1,line2;
LCD_driver L0(clk,"WELCOME TO CSE, ","IIT KANPUR      ", led_e, led_w, led_rs, data);


//assign line1=128'h57454C434F4D4520544F204353453333;
//assign line1=128'h75757057205720572057205720572057;
//assign line2=128'h20492049204920204B414E5055522020;


endmodule
