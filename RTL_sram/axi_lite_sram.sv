module axi_lite_sram (
    input  logic        clk,
    input  logic        rst_n,

    input  logic        awvalid,
    input  logic [7:0]  awaddr,
    input  logic        wvalid,
    input  logic [31:0] wdata,
    input  logic        arvalid,
    input  logic [7:0]  araddr,
    output logic [31:0] rdata
);

    logic we;
    logic [7:0] addr;

    assign we   = awvalid & wvalid;
    assign addr = we ? awaddr : araddr;

    sram u_sram (
        .clk   (clk),
        .we    (we),
        .addr  (addr),
        .wdata (wdata),
        .rdata (rdata)
    );
endmodule

