import uvm_pkg::*;
`include "uvm_macros.svh"
/*
class sram_reg_block extends uvm_reg_block;
  `uvm_object_utils(sram_reg_block)

  sram_data_reg data_reg;

  function new(string name="sram_reg_block");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();
    default_map = create_map("map", 0, 4, UVM_LITTLE_ENDIAN);

    data_reg = sram_data_reg::type_id::create("data_reg");
    data_reg.configure(this);
    data_reg.build();

    default_map.add_reg(data_reg, 'h0, "RW");
  endfunction
endclass
*/


import uvm_pkg::*;
`include "uvm_macros.svh"

class sram_reg_block extends uvm_reg_block;
  `uvm_object_utils(sram_reg_block)

  uvm_mem mem;

  function new(string name="sram_reg_block");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();
    // base=0, stride=4 bytes
    default_map = create_map("map", 0, 4, UVM_LITTLE_ENDIAN);

    // ✅ Vivado UVM 1.2 방식 (모든 정보는 new에서)
    mem = new(
      "mem",      // name
      256,        // depth (entries)
      32,         // n_bits
      "RW",       // access (STRING!)
      UVM_NO_COVERAGE
    );

    // ✅ configure는 parent만
    mem.configure(this);

    default_map.add_mem(mem, 'h0);
  endfunction

endclass

