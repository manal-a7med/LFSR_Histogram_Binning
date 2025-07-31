`timescale 1ns / 1ps

module s_axil_tb;
    // Clock and Reset
    reg aclk;
    reg aresetn;

    // AXI-Lite Signals
    reg [31:0] s_axil_awaddr;
    reg s_axil_awvalid;
    wire s_axil_awready;
    
    reg [31:0] s_axil_wdata;
    reg s_axil_wvalid;
    wire s_axil_wready;
    
    wire [1:0] s_axil_bresp;
    wire s_axil_bvalid;
    reg s_axil_bready;
    
    reg [31:0] s_axil_araddr;
    reg s_axil_arvalid;
    wire s_axil_arready;
    
    wire [31:0] s_axil_rdata;
    wire [1:0] s_axil_rresp;
    wire s_axil_rvalid;
    reg s_axil_rready;

    // AXI-Stream Master
    wire [31:0] m_axis_tdata;
    wire m_axis_tvalid;
    reg m_axis_tready;

    // Instantiate the DUT
    s_axil uut (
        .aclk(aclk),
        .aresetn(aresetn),
        .s_axil_awaddr(s_axil_awaddr),
        .s_axil_awvalid(s_axil_awvalid),
        .s_axil_awready(s_axil_awready),
        .s_axil_wdata(s_axil_wdata),
        .s_axil_wvalid(s_axil_wvalid),
        .s_axil_wready(s_axil_wready),
        .s_axil_bresp(s_axil_bresp),
        .s_axil_bvalid(s_axil_bvalid),
        .s_axil_bready(s_axil_bready),
        .s_axil_araddr(s_axil_araddr),
        .s_axil_arvalid(s_axil_arvalid),
        .s_axil_arready(s_axil_arready),
        .s_axil_rdata(s_axil_rdata),
        .s_axil_rresp(s_axil_rresp),
        .s_axil_rvalid(s_axil_rvalid),
        .s_axil_rready(s_axil_rready),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tvalid(m_axis_tvalid),
        .m_axis_tready(m_axis_tready)
    );

    // Clock generation
    always #5 aclk = ~aclk;

    initial begin
        aclk = 0;
        aresetn = 0;
        s_axil_awaddr = 0;
        s_axil_awvalid = 0;
        s_axil_wdata = 0;
        s_axil_wvalid = 0;
        s_axil_bready = 0;
        s_axil_araddr = 0;
        s_axil_arvalid = 0;
        s_axil_rready = 0;
        m_axis_tready = 1;
        
        // Reset sequence
        #20 aresetn = 1;
        
        // Write operation
        s_axil_awaddr = 32'h08;
        s_axil_awvalid = 1;
        s_axil_wdata = 32'hA5;
        s_axil_wvalid = 1;
        wait(s_axil_awready && s_axil_wready);
        #10 s_axil_awvalid = 0;
        s_axil_wvalid = 0;
        
        // Wait for write response
        s_axil_bready = 1;
        wait(s_axil_bvalid);
        #10 s_axil_bready = 0;
        
        // Read operation
        s_axil_araddr = 32'h08;
        s_axil_arvalid = 1;
        wait(s_axil_arready);
        #10 s_axil_arvalid = 0;
        
        // Wait for read data
        s_axil_rready = 1;
        wait(s_axil_rvalid);
        #10 s_axil_rready = 0;
        
        // Verify AXI-Stream Output
        wait(m_axis_tvalid);
        #10 $display("AXI Stream Output: %h", m_axis_tdata);
        
        #50 $finish;
    end
endmodule
