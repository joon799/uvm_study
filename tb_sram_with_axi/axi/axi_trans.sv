import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_trans extends uvm_sequence_item;

  rand bit        read;
  rand bit [31:0] addr;
  rand bit [31:0] wdata;
       bit [31:0] rdata;

  `uvm_object_utils(axi_trans)

  function new(string name="axi_trans");
    super.new(name);
  endfunction
endclass

