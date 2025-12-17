`ifndef COUNTER_MONITOR_SV
`define COUNTER_MONITOR_SV
import uvm_pkg::*;
`include "uvm_macros.svh"

class counter_monitor extends uvm_monitor;
    virtual counter_if vif;

    `uvm_component_utils(counter_monitor)
     uvm_analysis_port#(counter_trans) ap_port;

  
    function new(string name = "counter_monitor", uvm_component parent = null);
        super.new(name, parent);
        ap_port = new("ap_port", this);
     endfunction

    function void build_phase(uvm_phase phase);
        if (!uvm_config_db#(virtual counter_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF","No virtual interface")
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            @(posedge vif.clk);
            `uvm_info("MON",
                $sformatf("en=%0d count=%0d", vif.en, vif.count),
                UVM_LOW
            );
        end
    endtask
endclass
`endif

