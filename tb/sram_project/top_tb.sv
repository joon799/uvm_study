`timescale 1ns/1ps
import uvm_pkg::*;
import axi_vip_pkg::*;
import axi_vip_0_pkg::*;
`include "uvm_macros.svh"

module top_tb;

    logic clk = 0;
    logic rst_n = 0;
    always #5 clk = ~clk;

    initial begin
        #50 rst_n = 1;
    end
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, top_tb);
    end

    axi_vip_0_if axi_if(clk, rst_n);

    axi_lite_sram dut (
        .clk     (clk),
        .rst_n   (rst_n),
        .awvalid (axi_if.awvalid),
        .awaddr  (axi_if.awaddr),
        .wvalid  (axi_if.wvalid),
        .wdata   (axi_if.wdata),
        .arvalid (axi_if.arvalid),
        .araddr  (axi_if.araddr),
        .rdata   (axi_if.rdata)
    );

    axi_vip_0_mst_t axi_agent;

    initial begin
        axi_agent = new("axi_agent", axi_if);
        axi_agent.start_master();
        run_test("ral_test");
    end

endmodule

