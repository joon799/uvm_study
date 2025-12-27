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
    uvm_status_e     status;
    uvm_reg_data_t  rdata;

    phase.raise_objection(this);

    `uvm_info("TEST", "Starting AXI RAL test", UVM_LOW)

    // -----------------------------
    // WRITE via RAL
    // -----------------------------
    env.ral_block.data_reg.write(
      status,
      32'hDEADBEEF,
      UVM_FRONTDOOR
    );

    if (status != UVM_IS_OK)
      `uvm_error("RAL", "WRITE failed")

    // -----------------------------
    // READ via RAL  ⭐⭐⭐ 여기 핵심 ⭐⭐⭐
    // -----------------------------
    env.ral_block.data_reg.read(
      status,
      rdata,
      UVM_FRONTDOOR
    );

    if (status != UVM_IS_OK)
      `uvm_error("RAL", "READ failed")

    `uvm_info("RAL",
      $sformatf("Read data = 0x%08h", rdata),
      UVM_LOW
    )

    phase.drop_objection(this);
  endtask

endclass

`endif

