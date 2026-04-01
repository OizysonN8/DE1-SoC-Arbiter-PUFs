/*
Test Bench for muxChain designed to show its trivial simulated behaviour. 
WHAT CAN I ADD
*/
module muxChain_tb ();
	localparam CHALLENGE_WIDTH = 8; // Alter Challenge width
	localparam CHALLENGE_ONE = 8'b10010110; // <-- Change Challenge One
	localparam CHALLENGE_TWO = 8'b10011100; // <-- Change Challenge Two
	localparam CHALLENGE_THREE = 8'b00110111; // <-- Change Challenge Three

	logic in; 
	logic [CHALLENGE_WIDTH - 1 : 0] challenge;
	logic upper, lower;

	muxChain dut (.*);

	initial begin
		challenge <= CHALLENGE_ONE; #10;
		in <= 1; #10;
		in <= 0; #10;
		challenge <= CHALLENGE_TWO; #10;
		in <= 1; #10;
		in <= 0; #10;
		challenge <= CHALLENGE_THREE; #10;
		in <= 1; #10;
		in <= 0; #10;
	 $stop;  // pause the simulation
	end
endmodule  // muxChain