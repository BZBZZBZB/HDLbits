module top_module ();
reg clk;
reg reset;
reg t;
wire q;

initial begin
    reset = 1;
    clk = 1;
    t = 0;
    #20
    reset = 0;
    t = 1;
end
always #5 clk = ~clk;
tff u_tff(
    .clk(clk),
    .reset(reset),
    .t(t),
    .q(q)
);
endmodule