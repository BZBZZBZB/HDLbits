module top_module (input x, input y, output z);
wire z1;
wire z2;
wire z3;
wire z4;

assign z1 = (x^y) & x;
assign z2 = ~(x ^ y);
assign z3 = (x^y) & x;
assign z4 = ~(x ^ y);

assign z = (z1 | z2) ^ (z3 & z4);

endmodule