/*
A MUX chain that alters the propogation paths for the racing
signals depending on an n width Challenge bus
*/
module muxChain #(
	parameter CHALLENGE_WIDTH = 8 // Alter Challenge width
	) (
	input logic in, 
	input logic [CHALLENGE_WIDTH - 1 : 0] challenge,
	output logic upper, lower
	);
	
	// Wires between stages — one extra for input
    wire [CHALLENGE_WIDTH:0] path_a, path_b;

    // Feed input into stage 0
    assign path_a[0] = in;
    assign path_b[0] = in;

    // Generate one puf_stage per challenge bit
    genvar i;
    generate
        for (i = 0; i < CHALLENGE_WIDTH; i++) begin : stage
            muxStage m (
                .a_in    (path_a[i]),
                .b_in    (path_b[i]),
                .sel     (challenge[i]),
                .a_out   (path_a[i+1]),
                .b_out   (path_b[i+1])
            );
        end
    endgenerate

    assign upper = path_a[CHALLENGE_WIDTH];
    assign lower = path_b[CHALLENGE_WIDTH];
	 
 endmodule // muxChain