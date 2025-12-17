import uvm_pkg::*;
`include "uvm_macros.svh"

class counter_seq extends uvm_sequence #(counter_trans);

    `uvm_object_utils(counter_seq)

    function new(string name="counter_seq");
        super.new(name);
    endfunction

    task body();
        repeat (20) begin
            counter_trans tr = counter_trans::type_id::create("tr");
            start_item(tr);
            assert(tr.randomize());
            finish_item(tr);
        end
    endtask
endclass

