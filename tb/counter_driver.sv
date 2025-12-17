import uvm_pkg::*;
`include "uvm_macros.svh"

class counter_driver extends uvm_driver #(counter_trans);
    virtual counter_if vif;

    `uvm_component_utils(counter_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        if (!uvm_config_db#(virtual counter_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF","No virtual interface")
    endfunction

    task run_phase(uvm_phase phase);
        counter_trans tr;
        forever begin
            seq_item_port.get_next_item(tr);
            vif.en = tr.en;
            seq_item_port.item_done();
            @(posedge vif.clk);
        end
    endtask
endclass

