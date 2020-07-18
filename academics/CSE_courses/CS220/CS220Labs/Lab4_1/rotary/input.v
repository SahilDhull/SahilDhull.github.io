`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:56:30 02/12/2018 
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
module input( clk,r_a,r_b,r_event,r_dir  );
input clk,r_a,r_b;
output r_event,r_dir;
reg r_event,r_dir;

always@(posedge clk) begin
if (r_a==1 && r_b==1) begin
r_event=1;
end
if (r_a==0 && r_b==0) begin
r_event=0;
end
if (r_a==0 && r_b==1) begin
r_dir=1;
end
if (r_a==1 && r_b==0) begin
r_dir=0;
end

end

endmodule
