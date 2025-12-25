import uvm_pkg::*;
`include "uvm_macros.svh"

class env extends uvm_env;
    `uvm_component_utils(env)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
endclass

