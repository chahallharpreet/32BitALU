`timescale 1ns / 1ps

module tb_BIGALU();
reg  [31:0] A, B;
reg  [2:0]  F; 
wire [31:0] Y;
wire overflow, zero;

reg [31:0] expY;
reg expV, expZ;
reg [100:0] testvectors [0:13];
integer i;
integer errors;

BIGALU dut (.A(A), .B(B), .F(F), .Y(Y), .overflow(overflow), .zero(zero));

initial begin
$readmemb("C:/Users/chaha/test_vector_lab7.tv", testvectors);
errors = 0;

for (i = 0; i < 14; i = i + 1) begin
{F, A, B, expY, expV, expZ} = testvectors[i];
#10;

if (Y !== expY || overflow !== expV || zero !== expZ) begin
errors = errors + 1;
 $display("Test %0d FAILED", i + 1);
 end
 end

if (errors == 0)
$display("All 14 tests passed.");
else
$display("%0d of 14 tests failed.", errors);

$finish;
end

endmodule


