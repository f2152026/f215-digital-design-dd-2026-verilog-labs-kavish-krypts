// Four-bit dataflow CLA block used by the hierarchical bonus adder.
module cla4(
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);
  wire [3:0] p, g;
  wire [4:0] c;
  assign #(2) p = a ^ b;
  assign #(2) g = a & b;
  assign #(2) c[0] = cin;
  assign #(2) c[1] = g[0] | (p[0] & c[0]);
  assign #(2) c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c[0]);
  assign #(2) c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) |
                     (p[2] & p[1] & p[0] & c[0]);
  assign #(2) c[4] = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) |
                     (p[3] & p[2] & p[1] & g[0]) |
                     (p[3] & p[2] & p[1] & p[0] & c[0]);
  assign #(2) sum = p ^ c[3:0];
  assign #(2) cout = c[4];
endmodule
