`ifndef AXI_RAL_ADAPTER_SV
`define AXI_RAL_ADAPTER_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

/*
 * 반드시 axi_trans가 먼저 컴파일되어야 함
 * file.f에서 axi/axi_trans.sv 가 이 파일보다 위에 있어야 함
 */
class axi_ral_adapter extends uvm_reg_adapter;
  `uvm_object_utils(axi_ral_adapter)

  function new(string name = "axi_ral_adapter");
    super.new(name);
    supports_byte_enable = 0;
    provides_responses   = 1;
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
      tr.write = 1;
      tr.read  = 0;
      tr.wdata = rw.data;
    end
    else begin
      tr.write = 0;
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

    rw.addr = tr.

