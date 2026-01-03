`ifndef AXI_RAL_ADAPTER_SV
`define AXI_RAL_ADAPTER_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_ral_adapter extends uvm_reg_adapter;
  `uvm_object_utils(axi_ral_adapter)

  function new(string name = "axi_ral_adapter");
    super.new(name);
    supports_byte_enable = 0;
    provides_responses   = 0;
  endfunction

  // ------------------------------------------------------------
  // RAL → AXI transaction
  // ------------------------------------------------------------
  virtual function uvm_sequence_item reg2bus(
    const ref uvm_reg_bus_op rw
  );
    axi_trans tr;

    tr = axi_trans::type_id::create("tr");
    tr.addr = rw.addr;

    if (rw.kind == UVM_WRITE) begin
      tr.read  = 0;
      tr.wdata = rw.data;
    end
    else begin
      tr.read  = 1;
    end

    return tr;
  endfunction

  // ------------------------------------------------------------
  // AXI transaction → RAL
  // ------------------------------------------------------------
  virtual function void bus2reg(
    uvm_sequence_item bus_item,
    ref uvm_reg_bus_op rw
  );
    axi_trans tr;

    if (!$cast(tr, bus_item)) begin
      `uvm_fatal("RAL_ADAPTER", "bus_item is not axi_trans")
    end

    rw.addr = tr.addr;

    if (tr.read) begin
      rw.kind = UVM_READ;
      rw.data = tr.rdata;
    end
    else begin
      rw.kind = UVM_WRITE;
      rw.data = tr.wdata;
    end

    rw.status = UVM_IS_OK;
  endfunction

endclass

`endif

