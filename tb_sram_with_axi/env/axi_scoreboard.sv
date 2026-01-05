`ifndef AXI_SCOREBOARD_SV
`define AXI_SCOREBOARD_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_scoreboard extends uvm_component;
  `uvm_component_utils(axi_scoreboard)

  // monitor → scoreboard
  uvm_analysis_imp #(axi_trans, axi_scoreboard) ap;

  // 간단한 메모리 모델
  bit [31:0] mem [bit [31:0]];

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  // ---------------------------------
  // monitor에서 transaction 수신
  // ---------------------------------
virtual function void write(axi_trans tr);
  bit [31:0] addr_key;
  addr_key = tr.addr & 32'h000003FC;

  if (tr.read == 0) begin
    mem[addr_key] = tr.wdata;
    `uvm_info("SCOREBOARD",
      $sformatf("WRITE addr=0x%08h data=0x%08h",
                addr_key, tr.wdata),
      UVM_LOW)
  end
  else begin
    if (!mem.exists(addr_key)) begin
      `uvm_error("SCOREBOARD",
        $sformatf("READ addr=0x%08h but no previous WRITE",
                  addr_key))
    end
    else if (mem[addr_key] !== tr.rdata) begin
      `uvm_error("SCOREBOARD",
        $sformatf("READ MISMATCH addr=0x%08h exp=0x%08h got=0x%08h",
                  addr_key, mem[addr_key], tr.rdata))
    end
    else begin
      `uvm_info("SCOREBOARD",
        $sformatf("READ OK addr=0x%08h data=0x%08h",
                  addr_key, tr.rdata),
        UVM_LOW)
    end
  end
endfunction


endclass

`endif

