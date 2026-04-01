/*
FSM that unites the XORPUF and Majority Vote System
*/
module PUF_FSM (
    input  logic clk, reset,
    output logic advance_lfsr, trigger, count_mv, reset_mv, sample_pw, done
);

    logic [2:0] pulse_counter;
	 logic [7:0] challenge_counter;

	 enum logic [3:0] {start, load, pauseOne, pulse, pauseTwo, vote, check, sample, cycle, finished} ps, ns;

	always_comb begin
		case (ps)
			start: ns = ~reset ? load : start;
			load: ns = pauseOne;
			pauseOne: ns = pulse;
			pulse: ns = pauseTwo;
			pauseTwo: ns = vote;
			vote: ns = check;
			check: ns = pulse_counter < 3'b111 ? pulse : sample;
			sample: ns = cycle;
			cycle: ns = challenge_counter < 8'b11111110 ? load : finished;
			finished: ns = finished;
			default: ns = start;
		endcase
	end

	assign advance_lfsr = (ps == load);
	assign trigger = (ps == pulse);
	assign count_mv = (ps == vote);
	assign reset_mv = (ps == load);
	assign sample_pw = (ps == sample);
	assign done = (ps == finished);

	always_ff @(posedge clk)
	 if (reset)
		ps <= start;
	 else
		ps <= ns;
		
			// Pulse counter
	always_ff @(posedge clk) begin
		 if (reset || ps == load)
			  pulse_counter <= 3'b0;
		 else if (ps == vote)
			  pulse_counter <= pulse_counter + 1'b1;
	end

	// Challenge counter
	always_ff @(posedge clk) begin
		 if (reset)
			  challenge_counter <= 8'b0;
		 else if (ps == cycle)
			  challenge_counter <= challenge_counter + 1'b1;
	end


	endmodule  // CounterThree
