`ifndef COUNTER_SEQUENCER_SV
`define COUNTER_SEQUENCER_SV
//`include "xlnx_uvm_macro.svh"

class counter_sequencer extends uvm_sequencer #(counter_trans);
  `uvm_component_utils(counter_sequencer)

  function new(string name = "counter_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction

endclass

`endif

