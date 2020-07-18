`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:55:54 02/14/2018 
// Design Name: 
// Module Name:    square_grid 
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

module main( clk, s, r_b, r_a, newx, newy);

input clk, r_b, r_a;
wire r_event,r_dir;
input [3:0]s;
output wire [3:0]newx;
output wire [3:0]newy;

reg [3:0]X;
reg [3:0]Y;
initial X=0;
initial Y=0;
reg prev;
initial prev=1;
reg h=0,v=0,sign=0;
wire [4:0]c,d;
wire [7:0]carry;


reg [1:0] scopy;
rot R1(clk,r_a,r_b,r_event,r_dir);
always @(posedge clk)
begin
	prev <= r_event;
	if(prev == 0 && r_event == 1)
	begin
	   scopy <= s[1:0];
		if ( s[2] == 0 )
		begin
			h<=0;
			v<=1;
			sign<=s[3];
		end
		else if ( s[2] == 1 )
		begin
			h<=1;
			v<=0;
			sign<=s[3];
		end
		X<=newx;
		Y<=newy;
	end
end

//c=x+s
adder A0(X[0],scopy[0],sign,sign,c[0],carry[0]);
adder A1(X[1],scopy[1],sign,carry[0],c[1],carry[1]);
adder A2(X[2],0,sign,carry[1],c[2],carry[2]);
adder A3(X[3],0,sign,carry[2],c[3],carry[3]);
assign c[4]= (sign & (~carry[2] & ~X[3]) ) | (~sign & carry[3]);
//d=y+s
adder A4(Y[0],scopy[0],sign,sign,d[0],carry[4]);
adder A5(Y[1],scopy[1],sign,carry[4],d[1],carry[5]);
adder A6(Y[2],0,sign,carry[5],d[2],carry[6]);
adder A7(Y[3],0,sign,carry[6],d[3],carry[7]);
assign d[4]= (sign&(~carry[6])&~Y[3]) | (~sign & carry[7]);

assign newx[0]= (h&(~c[4])&c[0]) | (h&c[4]&(~sign))| ((~h)&X[0]);
assign newx[1]=(h&(~c[4])&c[1]) | (h&c[4]&(~sign)) | ((~h)&X[1]);
assign newx[2]=(h&(~c[4])&c[2]) | (h&c[4]&(~sign)) | ((~h)&X[2]);
assign newx[3]=(h&(~c[4])&c[3]) | (h&c[4]&(~sign)) | ((~h)&X[3]);
assign newy[0]=(v&(~d[4])&d[0]) | (v&d[4]&(~sign)) | ((~v)&Y[0]);
assign newy[1]=(v&(~d[4])&d[1]) | (v&d[4]&(~sign)) | ((~v)&Y[1]);
assign newy[2]=(v&(~d[4])&d[2]) | (v&d[4]&(~sign)) | ((~v)&Y[2]);
assign newy[3]=(v&(~d[4])&d[3]) | (v&d[4]&(~sign)) | ((~v)&Y[3]);


//assign newx = c[3:0];
//assign newy = d[3:0];

endmodule
