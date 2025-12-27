import uvm_pkg::*;
`include "uvm_macros.svh"

class sram_data_reg extends uvm_reg;
  `uvm_object_utils(sram_data_reg)

  function new(string name="sram_data_reg");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();
    uvm_reg_field f;
    f = uvm_reg_field::type_id::create("data");
    f.configure(this, 32, 0, "RW", 0, 0, 1, 0, 0);
  endfunction
endclass

