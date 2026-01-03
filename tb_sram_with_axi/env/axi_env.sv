`ifndef AXI_ENV_SV
`define AXI_ENV_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class axi_env extends uvm_env;

  `uvm_component_utils(axi_env)

  // -------------------------
  // 기존 구성요소
  // -------------------------
  axi_agent        agent;

  // -------------------------
  // RAL 관련 (⭐ 핵심 ⭐)
  // -------------------------
  sram_reg_block   ral_block;
  axi_ral_adapter  adapter;
  uvm_reg_predictor #(axi_trans) predictor;

  // -------------------------
  // ⭐ 추가: Scoreboard
  // -------------------------
  axi_scoreboard   scb;

  function new(string name = "axi_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    agent = axi_agent::type_id::create("agent", this);

    // -------------------------
    // RAL 생성
    // -------------------------
    ral_block = sram_reg_block::type_id::create("ral_block", this);
    ral_block.build();
    ral_block.lock_model();
    ral_block.reset();

    adapter   = axi_ral_adapter::type_id::create("adapter", this);
    predictor = uvm_reg_predictor#(axi_trans)::type_id::create("predictor", this);

    // -------------------------
    // ⭐ Scoreboard 생성
    // -------------------------
    scb = axi_scoreboard::type_id::create("scb", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // -------------------------
    // RAL predictor 연결
    // -------------------------
    predictor.map     = ral_block.default_map;
    predictor.adapter = adapter;

    agent.mon.ap_port.connect(predictor.bus_in);
    ral_block.default_map.set_sequencer(
    agent.m_sequencer,
    adapter
    );    // -------------------------
    // ⭐ monitor → scoreboard 연결
    // -------------------------
    agent.mon.ap_port.connect(scb.ap);
  endfunction

endclass

`endif

