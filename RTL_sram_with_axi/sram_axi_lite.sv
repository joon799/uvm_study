module sram_axi_lite (
  input  logic        ACLK,
  input  logic        ARESETn,

  input  logic [31:0] AWADDR,
  input  logic        AWVALID,
  output logic        AWREADY,

  input  logic [31:0] WDATA,
  input  logic        WVALID,
  output logic        WREADY,

  output logic [1:0]  BRESP,
  output logic        BVALID,
  input  logic        BREADY,

  input  logic [31:0] ARADDR,
  input  logic        ARVALID,
  output logic        ARREADY,

  output logic [31:0] RDATA,
  output logic [1:0]  RRESP,
  output logic        RVALID,
  input  logic        RREADY
);

  logic [31:0] mem [0:255];

  assign AWREADY = 1;
  assign WREADY  = 1;
  assign ARREADY = 1;

  always_ff @(posedge ACLK) begin
    if (!ARESETn) begin
      BVALID <= 0;
      RVALID <= 0;
    end else begin
      if (AWVALID && WVALID) begin
        mem[AWADDR[9:2]] <= WDATA;
        BVALID <= 1;
      end else if (BREADY) begin
        BVALID <= 0;
      end

      if (ARVALID) begin
        RDATA  <= mem[ARADDR[9:2]];
        RVALID <= 1;
      end else if (RREADY) begin
        RVALID <= 0;
      end
    end
  end

  assign BRESP = 2'b00;
  assign RRESP = 2'b00;

endmodule

