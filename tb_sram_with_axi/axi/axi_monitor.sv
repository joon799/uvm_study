import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_monitor extends uvm_monitor;
  `uvm_component_utils(axi_monitor)

  virtual axi_lite_if vif;

  // ⭐⭐⭐ 이게 없어서 에러났던 것 ⭐⭐⭐
  uvm_analysis_port #(axi_trans) ap_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap_port = new("ap_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual axi_lite_if)::get(this, "", "vif", vif))
      `uvm_fatal("MON", "virtual interface not set")
  endfunction

  task run_phase(uvm_phase phase);
    axi_trans tr;

    forever begin
      tr = axi_trans::type_id::create("tr");

      @(posedge vif.ACLK);

      // READ response 감지
      if (vif.RVALID && vif.RREADY) begin
        tr.read  = 1;
        tr.addr  = vif.ARADDR;
        tr.rdata = vif.RDATA;
        ap_port.write(tr);
      end

      // WRITE response 감지
      if (vif.BVALID && vif.BREADY) begin
        tr.read  = 0;
        tr.addr  = vif.AWADDR;
        ap_port.write(tr);
      end
    end
  endtask

endclass

