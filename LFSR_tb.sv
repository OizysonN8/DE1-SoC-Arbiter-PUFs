// Testbench for LFSR
module LFSR_tb ();
	logic clk, reset, enable;
	logic [7:0] random; // pseudorandom output

	LFSR dut (.*);

	// Set up the clock
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	logic [255:0][7:0] states; // Possible states
	logic [255:0] visited; // Which states have been visited
	integer i, count;

	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0;
		for (int j = 0; j < 255; j++) begin
			// Define each possible state
			states[j] = j;
			visited[j] = 1'b0;
		end
		repeat(256) begin 
			// Let clk cycles pass and record visited states
			i = random;
			enable <= 1; @(posedge clk);
			enable <= 0;
			visited[i] = 1'b1;
			@(posedge clk);
		end
		count = 0;
		for (int i = 0; i < 256; i++) begin
			if (~visited[i])
				// Display any possible states that we failed to visit
				$display("Failed to reach state %b", states[i]);
			else
				count = count + 1;
		end
		// Record number of states visited
		$display("LFSR was able to reach %0d", count, " states");
		$stop;  // pause the simulation
	end
endmodule  // LFSR_tb