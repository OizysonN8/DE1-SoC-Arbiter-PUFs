/*
Generates Pulses to race through the Arbiter PUF
*/
module pulseGenerator (
	input logic clk, reset, in, 
	output logic out);
	
  enum logic {ZERO, ONE} ps, ns;
  
  assign ns = in ? ONE : ZERO;
  
  always_ff @(posedge clk)
    ps <= reset ? ZERO : ns;
	 
  assign out = (ps == ZERO) & in;

endmodule  // pulseGenerator
