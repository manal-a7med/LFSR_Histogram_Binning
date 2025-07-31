module tb_s_m_hist();

    reg aclk;
    reg aresetn;
    
    // AXI-Stream Slave Interface
    reg [31:0] s_axis_tdata;
    reg s_axis_tvalid;
    wire s_axis_tready;
    
    // AXI-Stream Master Interface
    wire [31:0] m_axis_tdata;
    wire m_axis_tvalid;
    reg m_axis_tready;

    // Instantiate s_m_hist
    s_m_hist uut (
        .aclk(aclk),
        .aresetn(aresetn),
        .s_axis_tdata(s_axis_tdata),
        .s_axis_tvalid(s_axis_tvalid),
        .s_axis_tready(s_axis_tready),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tvalid(m_axis_tvalid),
        .m_axis_tready(m_axis_tready)
    );

    // Clock Generation
    always #5 aclk = ~aclk;

    initial begin
        // Initialize signals
        aclk = 0;
        aresetn = 0;
        s_axis_tvalid = 0;
        s_axis_tdata = 0;
        m_axis_tready = 1;

        // Reset pulse
        #10 aresetn = 1;

        // Apply Stimulus (sending values)
        #10 s_axis_tvalid = 1;
        s_axis_tdata = 32'h00000010;  // Value 16 (Bin 0)
        #10 s_axis_tdata = 32'h0000003F;  // Value 63 (Bin 1)
        #10 s_axis_tdata = 32'h0000007F;  // Value 127 (Bin 3)
        #10 s_axis_tdata = 32'h000000A5;  // Value 165 (Bin 5)
        #10 s_axis_tdata = 32'h000000E0;  // Value 224 (Bin 6)
        #10 s_axis_tdata = 32'h000000FF;  // Value 255 (Bin 7)
        #10 s_axis_tvalid = 0;

        // Wait for output
        #50 $finish;
    end

   // initial begin
   //     $dumpfile("tb_s_m_hist.vcd");
   //     $dumpvars(0, tb_s_m_hist);
   // end

endmodule
