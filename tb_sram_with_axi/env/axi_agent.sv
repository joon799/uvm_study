`ifndef AXI_AGENT_SV
`define AXI_AGENT_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_agent extends uvm_agent;

  `uvm_component_utils(axi_agent)

  axi_sequencer m_sequencer;
  axi_driver    m_driver;
  axi_monitor   mon;   // 🔴 반드시 필요

  function new(string name="axi_agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_sequencer = axi_sequencer::type_id::create("m_sequencer", this);
    m_driver    = axi_driver   ::type_id::create("m_driver",    this);
    mon         = axi_monitor  ::type_id::create("mon",         this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
  endfunction

endclass

`endif

