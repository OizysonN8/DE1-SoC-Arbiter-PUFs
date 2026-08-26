module muxStage (
    input  logic a_in,
    input  logic b_in,
    input  logic sel,
    output logic a_out,
    output logic b_out
);
    // Declarations FIRST
    (* keep *) logic a_out_int;
    (* keep *) logic b_out_int;

    // Assigns AFTER
    assign a_out_int = sel ? b_in : a_in;
    assign b_out_int = sel ? a_in : b_in;

    assign a_out = a_out_int;
    assign b_out = b_out_int;

endmodule
