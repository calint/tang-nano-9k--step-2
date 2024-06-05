`default_nettype none
`define DEBUG
`define INFO

module Top (
    input wire sys_clk,
    input wire sys_rst_n,
    output reg [5:0] led,
    input wire uart_rx,
    output wire uart_tx,
    input wire btn1
);

  BESPBRAM #(
      .ADDRESS_BITWIDTH(16),
      .DATA_BITWIDTH(32),
      .DATA_COLUMN_BITWIDTH(8)
  ) data (
      .clk(sys_clk),
      .write_enable(write_enable),
      .address(address),
      .data_in(data_in),
      .data_out(data_out)
  );

  reg  [ 3:0] write_enable;
  reg  [31:0] address;
  reg  [31:0] data_in;
  wire [31:0] data_out;

  reg  [ 3:0] state = 0;

  always @(posedge sys_clk) begin
    case (state)
      0: begin
        write_enable <= {0, 0, 0, 1};
        address <= 4;
        data_in <= 32'habcd_ef12;
        state <= 1;
      end
      1: begin
        state <= 2;
      end
      2: begin
        write_enable <= 0;
        address <= 4;
        state <= 3;
      end
      3: begin
        led <= data_out;
        address <= address + 1;
        state <= 0;
      end
    endcase
  end

endmodule

`undef DEBUG
`undef INFO
`default_nettype wire
