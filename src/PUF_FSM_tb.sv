// Testbench for PUF_FSM
module PUF_FSM_tb ();
	logic clk, reset; // inputs
	logic advance_lfsr, trigger, count_mv, reset_mv, sample_pw, done; // outputs

	PUF_FSM dut (.*);

	// Set up the clock
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0;
		repeat(8194) begin 
			@(posedge clk);
		end
		$stop;  // pause the simulation
	end
endmodule  // PUF_FSM_tb