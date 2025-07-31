// Testbench
module tb_lfsr_histogram_top;

    reg clk;
    reg rst_n;

    // Instantiate the top module
    lfsr_histogram_top uut (
        .clk(clk),
        .rst_n(rst_n)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_lfsr_histogram_top);

        clk = 0;
        rst_n = 0;
        #20;
        rst_n = 1;

        // Wait and observe waveform
        #500;
        $finish;
    end

endmodule