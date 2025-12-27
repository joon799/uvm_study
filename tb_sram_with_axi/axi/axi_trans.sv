import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_trans extends uvm_sequence_item;
  rand bit        write;
  rand bit [31:0] addr;
  rand bit [31:0] data;

  `uvm_object_utils(axi_trans)

  function new(string name="axi_trans");
    super.new(name);
  endfunction
endclass

