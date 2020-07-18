`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:36:30 01/31/2018 
// Design Name: 
// Module Name:    input 
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
module final(PB1,PB2,PB3,PB4,PB5,s,sum);
input PB1;
input PB2;
input PB3;
input PB4;
input PB5;
input [3:0]s;
reg [3:0]a;
reg [3:0]b;
reg [3:0]c;
reg [3:0]d;
reg [5:0]e;
reg [4:0]sum1;
reg [4:0]sum2;
reg [5:0]sum3;
output [6:0]sum;
wire [6:0]sum;
always @(posedge PB1) begin
	a[3:0] <= s[3:0];
end
always @(posedge PB2) begin
	b[3:0] <= s[3:0];
end
always @(posedge PB3) begin
	c[3:0] <=s[3:0];
end
always @(posedge PB4) begin
	d[3:0] <= s[3:0];
end
always @(posedge PB5) begin
	e[3:0] <= s[3:0];
	e[5:3] <= 3'b000;
end

four_adder F1 (a,b,sum1);
four_adder F2 (c,d,sum2);
five_adder F3 (sum1,sum2,sum3);
six_adder F4 (e,sum3,sum);

endmodule
