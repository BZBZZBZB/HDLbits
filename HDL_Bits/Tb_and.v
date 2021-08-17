module top_module();

reg [1:0]in;
wire out;
initial begin
    in[0] = 0;
    in[1] = 0;
    #10
    in[0] = 1;
    #10
    in[1] = 1;
    in[0] = 0;
    #10
    in[0] = 1;
end
andgate u_andgate(
    .in(in),
    .out(out)
);
endmodule