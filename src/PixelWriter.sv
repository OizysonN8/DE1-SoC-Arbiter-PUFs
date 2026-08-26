/*
Writes a response to a pixel in the 16x16 LED board with an address
*/
module PixelWriter (
    input  logic clk, reset,
    input  logic sample_pw,
    input  logic [7:0] challenge,
    input  logic result,
    output logic [15:0][15:0] RedPixels,
    output logic [15:0][15:0] GrnPixels
);

always_ff @(posedge clk) begin
    if (reset) begin
        RedPixels <= '0;
        GrnPixels <= '0;
		  RedPixels[0][0] <= 1'b1;  // give the trap state a value
		  GrnPixels[0][0] <= 1'b0;
    end else if (sample_pw) begin
        RedPixels[challenge[7:4]][challenge[3:0]] <= ~result; // 0 -> red
		  GrnPixels[challenge[7:4]][challenge[3:0]] <= result; // 1 -> green 
    end
end

endmodule

