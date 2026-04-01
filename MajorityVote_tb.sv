/*
Test bench for MajorityVote
*/
module MajorityVote_tb ();
	logic clk, reset, enable, response; // input
   logic average; // output

	MajorityVote dut (.*);

	// Set up the clock
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; response <= 1;
		repeat(7) begin
		enable <= 1; @(posedge clk);
		enable <= 0; @(posedge clk);
		end
	 $stop;  // pause the simulation
	end
endmodule  // MajorityVote_tb.sv