import uvm_pkg::*;
`include "uvm_macros.svh"

class counter_agent extends uvm_agent;
    counter_driver driver;
    counter_monitor monitor;
    counter_sequencer sequencer;
 uvm_analysis_port #(counter_trans) ap_port;
    `uvm_component_utils(counter_agent)

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        sequencer = counter_sequencer::type_id::create("sequencer", this);
        driver  = counter_driver::type_id::create("driver",  this);
        monitor = counter_monitor::type_id::create("monitor", this);
        ap_port = new("ap_port", this);
    endfunction

    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      driver.seq_item_port.connect(sequencer.seq_item_export);
      monitor.ap_port.connect(ap_port);
    endfunction
endclass

