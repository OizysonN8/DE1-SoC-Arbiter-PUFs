/*
8 bit Linear-Feedback Shift Register
*/
module LFSR (
	input logic clk, reset, enable,
	output logic [7:0] random // pseudorandom output
	);

	logic [7:0] line;
	logic [7:0] nextLine;

	always_comb begin
		nextLine[6:0] = line[7:1];
		nextLine[7] = line[0] ^ line[2] ^ line[3] ^ line[4];
	end

	always_ff @(posedge clk) begin
		if (reset) begin
			line <= 8'b1;
		end else if(enable) begin
			line[6:0] <= nextLine[6:0];
			line[7] <= nextLine[7];
		end
	end
	
	assign random = line;
	

endmodule  // LFSR
