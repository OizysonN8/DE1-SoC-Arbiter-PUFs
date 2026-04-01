/*
Simple Test Bench for the Arbiter
*/
module Arbiter_tb ();
	logic upper, lower, q;
	
	Arbiter dut (.*);
	
	initial begin
		// test clk arrives first
		lower <= 0; upper <= 0; #10;
		upper <= 1; #10;
		lower <= 1; #10;
		lower <= 0; upper <= 0; #10;
		lower <= 1; #10;
		upper <= 1; #10;
	 $stop;  // pause the simulation
	end
	
endmodule // Arbiter_tb
	
	