`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:38:15 02/05/2018 
// Design Name: 
// Module Name:    blink 
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

module blink(clk,led);
`define OFF_TIME 25000000
`define ON_TIME (OFF_TIME*2)

input clk;
output led;
reg led;
reg [26:0]counter;

initial counter=27'b0;

always@(posedge clk) begin
counter<=counter+1;
if (counter==25000000) begin
led<=0;
end
if (counter==50000000) begin
led<=1;
counter<=0;
end
end
endmodule
