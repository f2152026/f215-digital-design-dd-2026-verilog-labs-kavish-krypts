// Delay-annotated gate-level full adder reused by the 4-bit RCA.
module FA_Gate(
  input a,
  input b,
  input cin,
  output sum,
  output cout
);
  wire p;

  assign #(2) p = a ^ b;
  assign #(2) sum = p ^ cin;
  assign #(2) cout = (a & b) | (p & cin);
endmodule
