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

    // -----------------------------
    // WRITE transaction
    // -----------------------------
    if (tr.read == 0) begin
      mem[tr.addr] = tr.wdata;

      `uvm_info("SCOREBOARD",
        $sformatf("WRITE addr=0x%08h data=0x%08h",
                  tr.addr, tr.wdata),
        UVM_LOW)
    end

    // -----------------------------
    // READ transaction
    // -----------------------------
    else begin
      if (!mem.exists(tr.addr)) begin
        `uvm_error("SCOREBOARD",
          $sformatf("READ addr=0x%08h but no previous WRITE",
                    tr.addr))
      end
      else if (mem[tr.addr] !== tr.rdata) begin
        `uvm_error("SCOREBOARD",
          $sformatf("READ MISMATCH addr=0x%08h exp=0x%08h got=0x%08h",
                    tr.addr, mem[tr.addr], tr.rdata))
      end
      else begin
        `uvm_info("SCOREBOARD",
          $sformatf("READ OK addr=0x%08h data=0x%08h",
                    tr.addr, tr.rdata),
          UVM_LOW)
      end
    end
  endfunction

endclass

`endif

