/*
Makes a XORPUF using two ArbiterPufs
*/
module XORPUF #(
	parameter CHALLENGE_WIDTH = 8)
	(
	input logic clk, in, reset,
	input logic [CHALLENGE_WIDTH - 1 : 0] challenge,
	output logic out);
	
	logic a_out, b_out;
	logic pulse;
	
	pulseGenerator p (.clk(clk), .in(in), .reset(reset), .out(pulse));
	ArbiterPUF #(.CHALLENGE_WIDTH(8)) apuf (.in(pulse), .challenge(challenge), .out(a_out));
	ArbiterPUF #(.CHALLENGE_WIDTH(8)) bpuf (.in(pulse), .challenge(challenge), .out(b_out));
	
	assign out = a_out ^ b_out;

endmodule // XORPUF
