/*
Test Bench for pulseGenerator
*/
module pulseGenerator_tb ();
	logic clk, reset, in;
	logic out;

	pulseGenerator dut (.*);

	// Set up the clock
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	initial begin
		reset <= 1; in <= 0; @(posedge clk);
		reset <= 0; in <= 1; @(posedge clk);
		repeat(5); @(posedge clk);
		reset <= 1; in <= 0; @(posedge clk);
		reset <= 0; in <= 1; @(posedge clk);
		repeat(5); @(posedge clk);
	 $stop;  // pause the simulation
	end
endmodule  // pulseGenerator