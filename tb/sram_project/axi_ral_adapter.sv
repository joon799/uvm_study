import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_ral_adapter extends uvm_reg_adapter;
    `uvm_object_utils(axi_ral_adapter)

    function new(string name="axi_ral_adapter");
        super.new(name);
        supports_byte_enable = 0;
    endfunction
endclass

