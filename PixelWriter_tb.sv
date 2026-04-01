// Testbench for PixelWriter
module PixelWriter_tb ();
    logic clk, reset, sample_pw;
    logic [7:0] challenge;
    logic result;
    logic [15:0][15:0] RedPixels, GrnPixels;

    PixelWriter dut (.*);

    // Set up the clock
    parameter CLOCK_PERIOD = 100;
    initial begin
        clk <= 0;
        forever #(CLOCK_PERIOD/2) clk <= ~clk;
    end

    task check_pixel(
        input [3:0] row, col,
        input logic exp_red, exp_grn,
        input string label
    );
        if (RedPixels[row][col] !== exp_red || GrnPixels[row][col] !== exp_grn) begin
            $display("FAIL [%s] pixel[%0d][%0d]",
                     label, row, col, RedPixels[row][col], exp_red,
                     GrnPixels[row][col], exp_grn);
        end else begin
            $display("PASS [%s] pixel[%0d][%0d]", label, row, col);
        end
    endtask

    initial begin
        // Apply reset
        reset <= 1; sample_pw <= 0; challenge <= 0; result <= 0;
        @(posedge clk);
        reset <= 0; @(posedge clk);

        // Check reset state: all clear except trap state [0][0]
        check_pixel(0,  0,  1'b1, 1'b0, "Reset trap [0][0]");
        check_pixel(0,  1,  1'b0, 1'b0, "Reset clear [0][1]");
        check_pixel(7,  7,  1'b0, 1'b0, "Reset clear [7][7]");
        check_pixel(15, 15, 1'b0, 1'b0, "Reset clear [15][15]");

        // result=1 should write green (Red=0, Grn=1)
        challenge <= 8'h12; result <= 1'b1;
        sample_pw <= 1; @(posedge clk);
        sample_pw <= 0; @(posedge clk);
        check_pixel(1, 2, 1'b0, 1'b1, "result=1 green [1][2]");

        // result=0 should write red (Red=1, Grn=0)
        challenge <= 8'hA5; result <= 1'b0;
        sample_pw <= 1; @(posedge clk);
        sample_pw <= 0; @(posedge clk);
        check_pixel(10, 5, 1'b1, 1'b0, "result=0 red [10][5]");

        // Overwrite same address with opposite result
        challenge <= 8'h12; result <= 1'b0;
        sample_pw <= 1; @(posedge clk);
        sample_pw <= 0; @(posedge clk);
        check_pixel(1, 2, 1'b1, 1'b0, "Overwrite [1][2] to red");

        // No write when sample_pw is low
        challenge <= 8'hFF; result <= 1'b1;
        sample_pw <= 0; @(posedge clk);
        check_pixel(15, 15, 1'b0, 1'b0, "No write without sample_pw [15][15]");

        // Trap state should survive unrelated writes
        challenge <= 8'h33; result <= 1'b1;
        sample_pw <= 1; @(posedge clk);
        sample_pw <= 0; @(posedge clk);
        check_pixel(0, 0, 1'b1, 1'b0, "Trap [0][0] unchanged after write");

        // Re-assert reset and verify everything restores
        reset <= 1; @(posedge clk);
        reset <= 0; @(posedge clk);
        check_pixel(0,  0,  1'b1, 1'b0, "Re-reset trap [0][0]");
        check_pixel(1,  2,  1'b0, 1'b0, "Re-reset clears [1][2]");
        check_pixel(10, 5,  1'b0, 1'b0, "Re-reset clears [10][5]");

        // Corner pixel tests
        challenge <= 8'hFF; result <= 1'b1;
        sample_pw <= 1; @(posedge clk);
        sample_pw <= 0; @(posedge clk);
        check_pixel(15, 15, 1'b0, 1'b1, "Corner [15][15] green");
		  // gosh, do I really want to write these for a living?

        challenge <= 8'h0F; result <= 1'b0;
        sample_pw <= 1; @(posedge clk);
        sample_pw <= 0; @(posedge clk);
        check_pixel(0, 15, 1'b1, 1'b0, "Corner [0][15] red");

        $stop;
    end
endmodule // PixelWriter_tb
