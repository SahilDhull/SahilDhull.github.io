`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:58:26 02/12/2018 
// Design Name: 
// Module Name:    main 
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
module main(clk,r_a,r_b,s,l0,l1,l2,l3,l4,l5,l6,l7);
input clk,r_a,r_b;
input [3:0]s;
output l0,l1,l2,l3,l4,l5,l6,l7;
wire l0,l1,l2,l3,l4,l5,l6;
reg l7;
reg [2:0]c1;
initial c1=3'b000;

wire r_event,r_dir;
reg pevent;
initial pevent=1'b1;
reg [6:0]a;
reg [6:0]b;
wire [6:0]c;
wire x;
reg op;
rot R1(clk,r_a,r_b,r_event,r_dir);
always @(posedge clk) begin
pevent<=r_event;
if (pevent==0 && r_event==1) begin
if (c1==1) begin
a[3:0]<=s[3:0];
end
if (c1==2) begin
a[6:4]<=s[2:0];
end
if(c1==3) begin
b[3:0]<=s[3:0];
end
if(c1==4) begin
b[6:4]<=s[2:0];
end
if (c1==5) begin
op<=s[0];
end
if (c1==6) begin
c1<=0;
a<=0;
b<=0;
end
c1<=c1+1;
end
end

adder A0(a[0],b[0],op,op,l0,c[0]);
adder A1(a[1],b[1],op,c[0],l1,c[1]);
adder A2(a[2],b[2],op,c[1],l2,c[2]);
adder A3(a[3],b[3],op,c[2],l3,c[3]);
adder A4(a[4],b[4],op,c[3],l4,c[4]);
adder A5(a[5],b[5],op,c[4],l5,c[5]);
adder A6(a[6],b[6],op,c[5],l6,c[6]);

assign x=c[5]^c[6];

always@(posedge clk) begin
if (x==0) begin
l7<=1'b0;
end
if (x==1) begin
l7<=1'b1;
end
end


endmodule
