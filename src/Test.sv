/*
Module for testing for correct behaviour of Arbiter and XORPUF
Not utilized in final design
*/
module Test (
	input  logic       CLOCK_50,  // 50MHz clock
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
	output logic [9:0] LEDR,
	input  logic [3:0] KEY,
	input  logic [9:0] SW
	);

	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;

	logic out;
	logic reset;
	logic [7:0] challenge;
	
	assign reset = SW[9];
	assign challenge = SW[7:0];

	XORPUF #(.CHALLENGE_WIDTH(8)) xpuf (.clk(CLOCK_50), .reset(reset), .in(KEY[0]),
														.challenge(challenge), .out(out));
	
	always_comb begin
		if (out) begin
			HEX0 = 7'b1000000;
		end else begin
			HEX0 = 7'b1111001;
		end
	end

endmodule  // Test