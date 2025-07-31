// Top Module for LFSR with Histogram Binning System

module lfsr_histogram_top(
    input wire clk,
    input wire rst_n
);

    // AXI-Lite Control Signals
    wire [31:0] awaddr, wdata, araddr;
    wire awvalid, wvalid, arvalid;
    wire awready, wready, bvalid, arready, rvalid;
    wire [31:0] rdata;
    wire [1:0] bresp, rresp;
    wire bready, rready;

    // AXI-Stream Signals
    wire [31:0] stream_data_1, stream_data_2;
    wire stream_valid_1, stream_ready_1;
    wire stream_valid_2, stream_ready_2;

    s_axil axil_inst (
        .aclk(clk),
        .aresetn(rst_n),
        .s_axil_awaddr(awaddr),
        .s_axil_awvalid(awvalid),
        .s_axil_awready(awready),
        .s_axil_wdata(wdata),
        .s_axil_wvalid(wvalid),
        .s_axil_wready(wready),
        .s_axil_bresp(bresp),
        .s_axil_bvalid(bvalid),
        .s_axil_bready(bready),
        .s_axil_araddr(araddr),
        .s_axil_arvalid(arvalid),
        .s_axil_arready(arready),
        .s_axil_rdata(rdata),
        .s_axil_rresp(rresp),
        .s_axil_rvalid(rvalid),
        .s_axil_rready(rready),
        .m_axis_tdata(stream_data_1),
        .m_axis_tvalid(stream_valid_1),
        .m_axis_tready(stream_ready_1)
    );

    s_m_hist histogram_inst (
        .aclk(clk),
        .aresetn(rst_n),
        .s_axis_tdata(stream_data_1),
        .s_axis_tvalid(stream_valid_1),
        .s_axis_tready(stream_ready_1),
        .m_axis_tdata(stream_data_2),
        .m_axis_tvalid(stream_valid_2),
        .m_axis_tready(stream_ready_2)
    );

endmodule

