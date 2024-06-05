//
// verilog that synthesizes to single port RAM
// 32 bit address width 10 to 13 uses 1 SP RAM
//

`default_nettype none
`define DBG
`define INFO

module BESPBRAM #(
    parameter ADDRESS_BITWIDTH = 16,
    parameter DATA_BITWIDTH = 32,
    parameter DATA_COLUMN_BITWIDTH = 8
) (
    input wire clk,
    input wire [3:0] write_enable,  // 0: read  1: write
    input wire [ADDRESS_BITWIDTH-1:0] address,
    output reg [DATA_BITWIDTH-1:0] data_out,
    input wire [DATA_BITWIDTH-1:0] data_in
);

  reg [DATA_BITWIDTH-1:0] data[2**ADDRESS_BITWIDTH-1:0];

  integer i;
  always @(posedge clk) begin
    for (i = 0; i < 4; i = i + 1) begin
      if (write_enable[i]) begin
        data[address][
          (i+1)*DATA_COLUMN_BITWIDTH-1
          -:DATA_COLUMN_BITWIDTH
        ] <= data_in[(i+1)*DATA_COLUMN_BITWIDTH-1-:DATA_COLUMN_BITWIDTH];
      end
    end
    data_out <= data[address];
  end

endmodule

`undef DBG
`undef INFO
`default_nettype wire
