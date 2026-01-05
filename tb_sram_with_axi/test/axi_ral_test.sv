`ifndef AXI_RAL_TEST_SV
`define AXI_RAL_TEST_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_ral_test extends uvm_test;

  `uvm_component_utils(axi_ral_test)

  axi_env env;

  function new(string name = "axi_ral_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = axi_env::type_id::create("env", this);
  endfunction

task run_phase(uvm_phase phase);
  uvm_status_e   status;
  uvm_reg_data_t wdata, rdata;
  int unsigned addr;

  phase.raise_objection(this);

  repeat (5) begin
    addr  = $urandom_range(0, 255);
    wdata = $urandom();

    `uvm_info("TEST",
      $sformatf("WRITE mem[%0d] = 0x%08h", addr, wdata),
      UVM_LOW)

    env.ral_block.mem.write(
      status,
      addr,
      wdata,
      UVM_FRONTDOOR
    );

    env.ral_block.mem.read(
      status,
      addr,
      rdata,
      UVM_FRONTDOOR
    );

    `uvm_info("TEST",
      $sformatf("READ  mem[%0d] = 0x%08h", addr, rdata),
      UVM_LOW)
  end

  phase.drop_objection(this);
endtask

endclass

`endif

