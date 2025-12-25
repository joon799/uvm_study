`ifndef SRAM_DATA_REG_SV
`define SRAM_DATA_REG_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class sram_data_reg extends uvm_reg;

  rand uvm_reg_field data;

  `uvm_object_utils(sram_data_reg)

  function new(string name = "sram_data_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();
    data = uvm_reg_field::type_id::create("data");
    data.configure(
      this,        // parent
      32,          // size
      0,           // lsb_pos
      "RW",        // access
      0,           // volatile
      32'h0,       // reset
      1,           // has_reset
      0,           // is_rand
      0            // individually_accessible
    );
  endfunction

endclass

`endif

