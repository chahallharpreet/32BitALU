`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2026 05:33:01 PM
// Design Name: 
// Module Name: BIGALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module BIGALU( input [31:0] A, input [31:0] B, input [2:0] F, output reg [31:0] Y, output overflow, output zero);

 wire [31:0] BB;
 wire [31:0] S;
 wire less;

assign BB = F[2] ? ~B : B; //stores B or inverted B the whole thing
assign S = A + BB + F[2]; //With that we can do addition and subtraction A + B + 0 = A+B S = A +~b+1 = A-B
assign overflow = (F[1:0] == 2'b10) & ((~A[31] & ~BB[31] & S[31]) | (A[31] & BB[31] & ~S[31])); //checks if we have overflow, the equation was derived.
assign zero = (Y == 32'b0) ? 1'b1 : 1'b0; //1 if output is all zero

assign less  = S[31] ^ ((~A[31] & ~BB[31] & S[31]) |(A[31] & BB[31] & ~S[31])); //logic for slt

always@(*) begin

case (F[1:0])
2'b00: Y = A & BB; //this covers 100 and 000
2'b01: Y = A | BB; // this covers 101 and 001
2'b10: Y = S;
2'b11: begin
if (F[2] == 1'b1)
    Y = {31'b0, less}; //concat the less result to this. either will be 000...0001 or 000...0000. 1 if A<B, 0 if A>=B
    else
    Y = 32'b0;
    end
default: Y = 32'b0;
endcase

end

endmodule
