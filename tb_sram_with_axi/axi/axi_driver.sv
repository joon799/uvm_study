import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_driver extends uvm_driver #(axi_trans);
  `uvm_component_utils(axi_driver)

  virtual axi_lite_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual axi_lite_if)::get(this, "", "vif", vif))
      `uvm_fatal("DRV", "virtual interface not set")
  endfunction

  task run_phase(uvm_phase phase);
    axi_trans tr;

    forever begin
      seq_item_port.get_next_item(tr);

      // -----------------------------
      // WRITE
      // -----------------------------
      if (!tr.read) begin
        vif.AWADDR  <= tr.addr;
        vif.AWVALID <= 1;
        vif.WDATA   <= tr.wdata;
        vif.WVALID  <= 1;

        @(posedge vif.ACLK);
        vif.AWVALID <= 0;
        vif.WVALID  <= 0;

        vif.BREADY  <= 1;
        @(posedge vif.ACLK);
        vif.BREADY  <= 0;
      end
      // -----------------------------
      // READ
      // -----------------------------
      else begin
        vif.ARADDR  <= tr.addr;
        vif.ARVALID <= 1;

        @(posedge vif.ACLK);
        vif.ARVALID <= 0;

        vif.RREADY  <= 1;
        @(posedge vif.ACLK);
        tr.rdata = vif.RDATA;   // ⭐ READ 결과 캡처
        vif.RREADY <= 0;
      end

      seq_item_port.item_done();
    end
  endtask

endclass

