`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:04:29 02/12/2018 
// Design Name: 
// Module Name:    out 
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
module out(clk, r_event, r_dir,led0, led1, led2, led3, led4, led5, led6, led7    );
input clk, r_event, r_dir;
output led0, led1, led2, led3, led4, led5, led6, led7;
reg led0, led1, led2, led3, led4, led5, led6, led7;
initial led0=1'b1;
reg pevent;
initial pevent=1'b1;

always @(posedge clk) begin

pevent<=r_event;
if (pevent==0 && r_event==1) begin
if(r_dir==0) begin
led0 <= led1;
led1 <= led2;
led2 <= led3;
led3 <= led4;
led4 <= led5;
led5 <= led6;
led6 <= led7;
led7 <= led0;
end
if (r_dir==1) begin
led1 <= led0;
led2 <= led1;
led3 <= led2;
led4 <= led3;
led5 <= led4;
led6 <= led5;
led7 <= led6;
led0 <= led7;
end

end

end

endmodule
