module top_module ( input x, input y, output z );
//同或
assign z = ~(x ^ y);
endmodule