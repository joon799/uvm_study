`timescale 1ns/1ps
module counter (
    input logic clk,
    input logic rst_n,
    output logic [1:0] cnt
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            cnt <= 2'b00;
        else
            cnt <= cnt + 1;
    end

endmodule

