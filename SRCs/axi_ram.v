`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2025 01:15:25 PM
// Design Name: 
// Module Name: axi_ram
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module axi_ram (
    input aclk,
    input aresetn,

    // AXI-Lite Slave Interface
    input [7:0] axi_awaddr,
    input axi_awvalid,
    output reg axi_awready,
    input [31:0] axi_wdata,
    input axi_wvalid,
    output reg axi_wready,
    output reg [31:0] axi_rdata,
    input axi_arvalid,
    input [7:0] axi_araddr,
    output reg axi_arready,
    output reg axi_rvalid
);

    reg [7:0] mem [0:287]; // 0x120 x 8-bit memory
    reg [7:0] bin_count [0:7];
    integer i;

    always @(posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            for (i = 0; i < 8; i = i + 1) 
                bin_count[i] <= 0;
            axi_awready <= 1;
            axi_wready <= 1;
            axi_arready <= 1;
            axi_rvalid <= 0;
        end else begin
            if (axi_awvalid && axi_awready) begin
                axi_awready <= 0;
                if (axi_wvalid && axi_wready) begin
                    axi_wready <= 0;
                    if (axi_awaddr < 8'h20) begin
                        bin_count[axi_awaddr[4:2]] <= axi_wdata[7:0];
                    end else if (axi_awaddr < 8'h120) begin
                        mem[axi_awaddr - 8'h20] <= axi_wdata[7:0];
                    end
                end
            end else begin
                axi_awready <= 1;
                axi_wready <= 1;
            end

            if (axi_arvalid && axi_arready) begin
                axi_arready <= 0;
                if (axi_araddr < 8'h20) begin
                    axi_rdata <= {24'b0, bin_count[axi_araddr[4:2]]};
                end else if (axi_araddr < 8'h120) begin
                    axi_rdata <= {24'b0, mem[axi_araddr - 8'h20]};
                end
                axi_rvalid <= 1;
            end else begin
                axi_arready <= 1;
                axi_rvalid <= 0;
            end
        end
    end
endmodule
