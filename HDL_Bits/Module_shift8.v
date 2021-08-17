module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
wire [7:0] q_delay1;
wire [7:0] q_delay2;
wire [7:0] q_delay3;

reg [7:0] q_reg;

my_dff8(
    .clk(clk),
    .d(d),
    .q(q_delay1)
);

my_dff8(
    .clk(clk),
    .d(q_delay1),
    .q(q_delay2)
);

my_dff8(
    .clk(clk),
    .d(q_delay2),
    .q(q_delay3)
);



always @(sel) begin
    case (sel)
        0:q_reg <= d;
        1:q_reg <= q_delay1;
        2:q_reg <= q_delay2;
        3:q_reg <= q_delay3;
        default:q_reg = 0;
    endcase
end

assign q = q_reg;

endmodule