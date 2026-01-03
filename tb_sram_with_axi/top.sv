import uvm_pkg::*;
`include "uvm_macros.svh"

module top;
  logic ACLK = 0;
  always #5 ACLK = ~ACLK;

  axi_lite_if axi_if(ACLK);

  sram_axi_lite dut (
    .ACLK    (ACLK),
    .ARESETn (axi_if.ARESETn),
    .AWADDR  (axi_if.AWADDR),
    .AWVALID (axi_if.AWVALID),
    .AWREADY (axi_if.AWREADY),
    .WDATA   (axi_if.WDATA),
    .WVALID  (axi_if.WVALID),
    .WREADY  (axi_if.WREADY),
    .BRESP   (axi_if.BRESP),
    .BVALID  (axi_if.BVALID),
    .BREADY  (axi_if.BREADY),
    .ARADDR  (axi_if.ARADDR),
    .ARVALID (axi_if.ARVALID),
    .ARREADY (axi_if.ARREADY),
    .RDATA   (axi_if.RDATA),
    .RRESP   (axi_if.RRESP),
    .RVALID  (axi_if.RVALID),
    .RREADY  (axi_if.RREADY)
  );

  initial begin
    axi_if.ARESETn = 0;
//    repeat (5) @(posedge ACLK);
#5;
    axi_if.ARESETn = 1;
  end

  initial begin
    uvm_config_db#(virtual axi_lite_if)::set(null, "*", "vif", axi_if);
  end

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, top);
    run_test("axi_ral_test");
  end
endmodule

