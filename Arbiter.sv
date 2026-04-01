/*
Arbiter
*/
module Arbiter (
    input  logic upper,
    input  logic lower,
    output logic q
);

    always_latch begin
        if (upper & ~lower)
            q = 1'b1;
        else if (lower & ~upper)
            q = 1'b0;
    end

endmodule

