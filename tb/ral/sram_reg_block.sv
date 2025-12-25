import uvm_pkg::*;
`include "uvm_macros.svh"
`include "sram_data_reg.sv"

class sram_reg_block extends uvm_reg_block;
  `uvm_object_utils(sram_reg_block)

  sram_data_reg data_reg;

  function new(string name = "sram_reg_block");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

  virtual function void build();

    data_reg = sram_data_reg::type_id::create("data_reg");
    data_reg.configure(this, null, "");
    data_reg.build();

    default_map = create_map(
      "default_map",
      'h0,
      4,
      UVM_LITTLE_ENDIAN
    );

    default_map.add_reg(data_reg, 'h0, "RW");
  endfunction
endclass

