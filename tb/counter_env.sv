import uvm_pkg::*;
`include "uvm_macros.svh"

class counter_env extends uvm_env;
    counter_agent agent;
    uvm_analysis_export #(counter_trans) ap_export;

    `uvm_component_utils(counter_env)

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        agent = counter_agent::type_id::create("agent", this);
        ap_export = new("ap_export", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agent.ap_port.connect(ap_export);
    endfunction
endclass

