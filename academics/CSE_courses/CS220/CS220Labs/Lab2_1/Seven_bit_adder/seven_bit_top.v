`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:16:48 01/31/2018
// Design Name:   Seven_bit_input
// Module Name:   /media/sahild/Elements/CS220/CS220Labs/Lab2_1/Seven_bit_adder/seven_bit_top.v
// Project Name:  Seven_bit_adder
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Seven_bit_input
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module seven_bit_top;

	// Inputs
	reg PB1;
	reg PB2;
	reg PB3;
	reg PB4;
	reg [3:0] s;

	// Outputs
	wire [7:0] sum;
	wire [5:0] carry;

	// Instantiate the Unit Under Test (UUT)
	Seven_bit_input uut (
		.PB1(PB1), 
		.PB2(PB2), 
		.PB3(PB3), 
		.PB4(PB4), 
		.s(s), 
		.sum(sum), 
		.carry(carry)
	);

always @(sum or carry)
 begin
   $display("time=%d: sum = %b, carry = %b\n",$time,sum,carry);   
 end

	initial begin
		#20
		$finish;
	end
 
initial begin 
	PB1=1'b1;s[3:0]=4'b0101;
	#2
	PB2=1'b1;s[2:0]=3'b010;
	#2
	PB3=1'b1;s[3:0]=4'b0101;
	#2
	PB4=1'b1;s[2:0]=3'b010;
end
endmodule

