/*
Defines the behaviour for a 3-bit counter used to find the average
response of a PUF to the same challenge
*/
module MajorityVote (
    input  logic clk, reset, enable, response,
    output logic average // Average response
);

    logic [2:0] count;

    always_ff @(posedge clk) begin
		 if (reset) begin
			  count <= 3'b0;
		 end else if (enable) begin
			  count <= count + response;
		 end
	end

	assign average = (count >= 3'b100);

endmodule  // MajorityVote
