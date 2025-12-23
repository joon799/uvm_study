`ifndef COUNTER_SCOREBOARD_SV
`define COUNTER_SCOREBOARD_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class counter_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(counter_scoreboard)

    // monitor에서 들어오는 분석 포트 받기
    uvm_analysis_imp #(counter_trans, counter_scoreboard) ap_imp;

    function new(string name = "counter_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        ap_imp = new("ap_imp", this);
    endfunction

    // monitor → scoreboard 데이터 수신 함수
    function void write(counter_trans tr);
        `uvm_info("SB",
            $sformatf("Scoreboard got count=%0d", tr.count),
            UVM_LOW)
    endfunction

endclass

`endif

