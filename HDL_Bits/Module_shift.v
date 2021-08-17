module top_module ( input clk, input d, output q );
wire q_delay1;
wire q_delay2;
wire q_delay3;

my_dff(
    .clk(clk),
    .d(d),
    .q(q_delay1)
);

my_dff(
    .clk(clk),
    .d(q_delay1),
    .q(q_delay2)
);
my_dff(
    .clk(clk),
    .d(q_delay2),
    .q(q_delay3)
);

assign q = q_delay3;
endmodule