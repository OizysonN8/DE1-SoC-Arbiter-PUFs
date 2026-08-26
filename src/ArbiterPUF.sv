/*
Combines submodules of ArbiterPUF
*/
module ArbiterPUF #(
	parameter CHALLENGE_WIDTH = 8)
	(
	input logic in,
	input logic [CHALLENGE_WIDTH - 1 : 0] challenge,
	output logic out);
	
	logic upper;
	logic lower;
	
	muxChain #(.CHALLENGE_WIDTH(CHALLENGE_WIDTH)) mc (.in(in), .challenge(challenge),
																		.upper(upper), .lower(lower));
	Arbiter arb (.upper(upper), .lower(lower), .q(out));

endmodule // ArbiterPUF
