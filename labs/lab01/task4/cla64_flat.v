// cla64_flat.v
// Procedural 64-bit carry-lookahead-style implementation for this variant.

module cla64_flat(
  input  [63:0] a,
  input  [63:0] b,
  input         cin,
  output [63:0] sum,
  output        cout
);

  reg [63:0] p;
  reg [63:0] g;
  reg [64:0] c;
  reg [63:0] calculated_sum;
  reg        calculated_cout;
  integer    bit_index;

  always @* begin
    p = a ^ b;
    g = a & b;
    c = 65'b0;
    calculated_sum = 64'b0;
    c[0] = cin;

    for (bit_index = 0; bit_index < 64; bit_index = bit_index + 1) begin
      calculated_sum[bit_index] = p[bit_index] ^ c[bit_index];
      c[bit_index + 1] = g[bit_index] |
                         (p[bit_index] & c[bit_index]);
    end

    calculated_cout = c[64];
  end

  assign #(2) sum = calculated_sum;
  assign #(2) cout = calculated_cout;

endmodule
