//
// verilog that synthesizes to single port RAM
// 32 bit address width 10 to 13 uses 1 SP RAM
//

`default_nettype none
`define DBG
`define INFO

module SPBRAM #(
    parameter ADDRESS_BITWIDTH = 16,
    parameter DATA_BITWIDTH = 32
) (
    input wire clk,
    input wire write_enable,
    input wire [ADDRESS_BITWIDTH-1:0] address,
    output reg [DATA_BITWIDTH-1:0] data_out,
    input wire [DATA_BITWIDTH-1:0] data_in
);

  reg [DATA_BITWIDTH-1:0] data[2**ADDRESS_BITWIDTH-1:0];

  always @(posedge clk) begin
    if (write_enable == 1) begin
      data[address] <= data_in;
    end
    data_out <= data[address];
  end

endmodule

`undef DBG
`undef INFO
`default_nettype wire
