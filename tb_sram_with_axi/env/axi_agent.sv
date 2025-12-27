`ifndef AXI_AGENT_SV
`define AXI_AGENT_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_agent extends uvm_agent;

  `uvm_component_utils(axi_agent)

  // components
  axi_sequencer seqr;
  axi_driver    drv;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seqr = axi_sequencer::type_id::create("seqr", this);
    drv  = axi_driver   ::type_id::create("drv",  this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction

endclass

`endif

