import uvm_pkg::*;
`include "uvm_macros.svh"

`include "counter_if.sv"
`include "counter_trans.sv"
`include "counter_sequencer.sv"
`include "counter_seq.sv"
`include "counter_driver.sv"
`include "counter_monitor.sv"
`include "counter_agent.sv"
`include "counter_env.sv"
`include "counter_test.sv"


module top;
    logic clk = 0;
    always #5 clk = ~clk;

    counter_if cif(clk);

    counter dut(
        .clk(clk),
        .rst_n(cif.rst_n),
        .en(cif.en),
        .count(cif.count)
    );

    initial begin
        cif.rst_n = 0;
        repeat(5) @(posedge clk);
        cif.rst_n = 1;
    end
  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, top);
  end
    initial begin
        run_test("counter_test");
    end

endmodule

