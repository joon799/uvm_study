import uvm_pkg::*;
`include "uvm_macros.svh"

class ral_test extends uvm_test;
    sram_reg_block regmodel;

    `uvm_component_utils(ral_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        regmodel = sram_reg_block::type_id::create("regmodel");
        regmodel.build();
        regmodel.lock_model();
    endfunction

    task run_phase(uvm_phase phase);
        uvm_status_e status;

        phase.raise_objection(this);

        `uvm_info("TEST", "SRAM RAL write/read", UVM_LOW)

        regmodel.mem[4].write(status, 32'hDEADBEEF);
        regmodel.mem[4].read (status, );

        #100;
        phase.drop_objection(this);
    endtask
endclass

