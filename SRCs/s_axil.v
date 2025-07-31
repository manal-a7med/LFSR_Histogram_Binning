`timescale 1ns / 1ps

module s_axil (
    input wire aclk,
    input wire aresetn,

    // AXI-Lite Slave Interface
    input wire [31:0] s_axil_awaddr,
    input wire s_axil_awvalid,
    output reg s_axil_awready,
    
    input wire [31:0] s_axil_wdata,
    input wire s_axil_wvalid,
    output reg s_axil_wready,
    
    output reg [1:0] s_axil_bresp,
    output reg s_axil_bvalid,
    input wire s_axil_bready,
    
    input wire [31:0] s_axil_araddr,
    input wire s_axil_arvalid,
    output reg s_axil_arready,
    
    output reg [31:0] s_axil_rdata,
    output reg [1:0] s_axil_rresp,
    output reg s_axil_rvalid,
    input wire s_axil_rready,

    // AXI-Stream Master
    output reg [31:0] m_axis_tdata,
    output reg m_axis_tvalid,
    input wire m_axis_tready
);

    reg [31:0] memory [0:255]; // Simple memory for AXI Lite
    reg [31:0] seed;
    
    always @(posedge aclk) begin
        if (!aresetn) begin
            s_axil_awready <= 0;
            s_axil_wready <= 0;
            s_axil_bvalid <= 0;
            s_axil_arready <= 0;
            s_axil_rvalid <= 0;
            m_axis_tvalid <= 0;
            seed <= 0;
        end else begin
            // AXI Write Address and Data Handshake
            if (s_axil_awvalid && s_axil_wvalid && !s_axil_awready && !s_axil_wready) begin
                s_axil_awready <= 1;
                s_axil_wready <= 1;
                memory[s_axil_awaddr[7:0]] <= s_axil_wdata; // Store in memory
                if (s_axil_awaddr == 32'h08) seed <= s_axil_wdata;
            end else begin
                s_axil_awready <= 0;
                s_axil_wready <= 0;
            end

            // AXI Write Response (bvalid)
            if (s_axil_awready && s_axil_wready && !s_axil_bvalid) begin
                s_axil_bvalid <= 1;
                s_axil_bresp <= 2'b00;
            end else if (s_axil_bvalid && s_axil_bready) begin
                s_axil_bvalid <= 0;
            end
            
            // AXI Read Address Handshake
            if (s_axil_arvalid && !s_axil_arready) begin
                s_axil_arready <= 1;
            end else begin
                s_axil_arready <= 0;
            end

            // AXI Read Data Response
         //   if (s_axil_arready && s_axil_arvalid && !s_axil_rvalid) begin
         //       s_axil_rvalid <= 1;
         //       s_axil_rdata <= memory[s_axil_araddr[7:0]];
         //       s_axil_rresp <= 2'b00;
         //   end else if (s_axil_rvalid && s_axil_rready) begin
         //       s_axil_rvalid <= 0;
         //   end
            
            // AXI Read Data
            if (s_axil_arvalid && !s_axil_arready) begin
                s_axil_arready <= 1;
            end else begin
                s_axil_arready <= 0;
            end

            if (s_axil_arready && !s_axil_rvalid) begin
                s_axil_rvalid <= 1;
                s_axil_rdata <= memory[s_axil_araddr[7:0]];  // Fix: Ensure proper data read
                s_axil_rresp <= 2'b00; // OKAY response
            end else if (s_axil_rvalid && s_axil_rready) begin
                s_axil_rvalid <= 0;
            end


            // AXI Stream Logic
            if (m_axis_tready && !m_axis_tvalid) begin
                m_axis_tvalid <= 1;
                m_axis_tdata <= seed + 2; // Some transformation
            end else if (m_axis_tvalid && m_axis_tready) begin
                m_axis_tvalid <= 0;
            end
        end
    end
endmodule
