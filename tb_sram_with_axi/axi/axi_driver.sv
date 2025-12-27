import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_driver extends uvm_driver #(axi_trans);
  `uvm_component_utils(axi_driver)

  virtual axi_lite_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    uvm_config_db#(virtual axi_lite_if)::get(this,"","vif",vif);
  endfunction

  task run_phase(uvm_phase phase);
    axi_trans tr;
    forever begin
      seq_item_port.get_next_item(tr);
      if (tr.write) begin
        vif.AWADDR  <= tr.addr;
        vif.AWVALID <= 1;
        vif.WDATA   <= tr.data;
        vif.WVALID  <= 1;
        @(posedge vif.ACLK);
        vif.AWVALID <= 0;
        vif.WVALID  <= 0;
        vif.BREADY  <= 1;
      end else begin
        vif.ARADDR  <= tr.addr;
        vif.ARVALID <= 1;
        @(posedge vif.ACLK);
        vif.ARVALID <= 0;
        vif.RREADY  <= 1;
      end
      seq_item_port.item_done();
    end
  endtask
endclass

