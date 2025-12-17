import uvm_pkg::*;
`include "uvm_macros.svh"

class counter_trans extends uvm_sequence_item;
    rand bit en;

    `uvm_object_utils(counter_trans)

    function new(string name="counter_trans");
        super.new(name);
    endfunction
endclass

