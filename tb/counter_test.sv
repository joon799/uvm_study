import uvm_pkg::*;
`include "uvm_macros.svh"

class counter_test extends uvm_test;
    counter_env env;

    `uvm_component_utils(counter_test)

    function new(string n, uvm_component p);
        super.new(n,p);
    endfunction

    function void build_phase(uvm_phase phase);
        env = counter_env::type_id::create("env", this);
    endfunction

    task run_phase(uvm_phase phase);
        counter_seq seq = counter_seq::type_id::create("seq");
        phase.raise_objection(this);
//        seq.start(env.agent.driver.seq_item_port);
        
        seq.start(env.agent.sequencer);
        phase.drop_objection(this);
    endtask
endclass

