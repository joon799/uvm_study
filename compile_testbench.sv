`timescale 1ns/1ps

module test;

    logic clk;
    logic rst_n;
    logic [1:0] cnt;

    // DUT 인스턴스
    counter dut (
        .clk(clk),
        .rst_n(rst_n),
        .cnt(cnt)
    );

    // Clock 생성
    initial clk = 0;
    always #5 clk = ~clk;  // 10ns 주기

    // Test 시나리오
    initial begin
        rst_n = 0;
        #12;
        rst_n = 1;

        // 50ns 동안 시뮬레이션
        #50;

        $display("Simulation finished");
        $finish;
    end

    // Waveform 출력
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, test);
    end

endmodule

