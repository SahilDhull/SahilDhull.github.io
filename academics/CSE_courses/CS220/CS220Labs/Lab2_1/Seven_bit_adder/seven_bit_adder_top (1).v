`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:56:50 01/31/2018
// Design Name:   Seven_bit_input
// Module Name:   /media/sahild/Elements/CS220/CS220Labs/Lab2_1/Seven_bit_adder/seven_bit_adder_top.v
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

module seven_bit_adder_top;

	// Inputs
	reg PB1;
	reg PB2;
	reg PB3;
	reg PB4;

	// Instantiate the Unit Under Test (UUT)
	Seven_bit_input uut (
		.PB1(PB1), 
		.PB2(PB2), 
		.PB3(PB3), 
		.PB4(PB4)
	);

always @([7:0]sum or [5:0]carry) begin
$display("time=%d: %b + %b + %b = %b, cout = %b\n", $time, a, b, cin,
sum, cout);
end
	initial begin
	

	end
      
endmodule

