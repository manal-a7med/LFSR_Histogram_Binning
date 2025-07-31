module tb_axi_ram;
    reg aclk;
    reg aresetn;
    reg [7:0] axi_awaddr;
    reg axi_awvalid;
    wire axi_awready;
    reg [31:0] axi_wdata;
    reg axi_wvalid;
    wire axi_wready;
    reg [7:0] axi_araddr;
    reg axi_arvalid;
    wire axi_arready;
    wire [31:0] axi_rdata;
    wire axi_rvalid;

    axi_ram uut (
        .aclk(aclk),
        .aresetn(aresetn),
        .axi_awaddr(axi_awaddr),
        .axi_awvalid(axi_awvalid),
        .axi_awready(axi_awready),
        .axi_wdata(axi_wdata),
        .axi_wvalid(axi_wvalid),
        .axi_wready(axi_wready),
        .axi_araddr(axi_araddr),
        .axi_arvalid(axi_arvalid),
        .axi_arready(axi_arready),
        .axi_rdata(axi_rdata),
        .axi_rvalid(axi_rvalid)
    );

    always begin
        aclk = 0; #5;
        aclk = 1; #5;
    end

    initial begin
        aresetn = 0;
        axi_awaddr = 0;
        axi_awvalid = 0;
        axi_wdata = 0;
        axi_wvalid = 0;
        axi_araddr = 0;
        axi_arvalid = 0;
        #20 aresetn = 1;
        
        // Write to Bin 3 count register (Address 0x0C)
        #10;
        axi_awaddr = 8'h0C;
        axi_awvalid = 1;
        axi_wdata = 32'h00000005;
        axi_wvalid = 1;
        #10;
        axi_awvalid = 0;
        axi_wvalid = 0;
        
        // Read from Bin 3 count register
        #10;
        axi_araddr = 8'h0C;
        axi_arvalid = 1;
        #10;
        axi_arvalid = 0;
        
        // Write a value to Bin 3 data storage (Address 0x80)
        #10;
        axi_awaddr = 8'h80;
        axi_awvalid = 1;
        axi_wdata = 32'h000000A5;
        axi_wvalid = 1;
        #10;
        axi_awvalid = 0;
        axi_wvalid = 0;
        
        // Read from Bin 3 data storage
        #10;
        axi_araddr = 8'h80;
        axi_arvalid = 1;
        #10;
        axi_arvalid = 0;
        
        #20;
        $finish;
    end
    
    initial begin
        $display("Time	Read Addr	Read Data	Read Valid");
        forever begin
            #10;
            if (axi_rvalid) $display("%t	%h	%h	%b", $time, axi_araddr, axi_rdata, axi_rvalid);
        end
    end
endmodule
