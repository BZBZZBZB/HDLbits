module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); //
assign c_enable = enable;
assign c_d = c_load ? 1 : 0;
assign c_load = reset | (Q == 12 && enable == 1);
    count4 u_count(
        .clk(clk),
        .enable(c_enable),
        .load(c_load),
        .d(c_d),
        .Q(Q)
    );

endmodule