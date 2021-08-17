module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
MUXDFF u_MUXDFF_1(
    .clk(KEY[0]),
    .E(KEY[1]),
    .L(KEY[2]),
    .w(LEDR[1]),
    .R(SW[0]),
    .Q(LEDR[0])
);

MUXDFF u_MUXDFF_2(
    .clk(KEY[0]),
    .E(KEY[1]),
    .L(KEY[2]),
    .w(LEDR[2]),
    .R(SW[1]),
    .Q(LEDR[1])
);

MUXDFF u_MUXDFF_3(
    .clk(KEY[0]),
    .E(KEY[1]),
    .L(KEY[2]),
    .w(LEDR[3]),
    .R(SW[2]),
    .Q(LEDR[2])
);

MUXDFF u_MUXDFF_4(
    .clk(KEY[0]),
    .E(KEY[1]),
    .L(KEY[2]),
    .w(KEY[3]),
    .R(SW[3]),
    .Q(LEDR[3])
);
endmodule

module MUXDFF (
    input clk,
    input E,
    input L,
    input w,
    input R,
    output Q
);
reg Q_reg;
wire [1:0] opt;
assign opt = {E,L};

always @(posedge clk)begin
    case (opt)
        2'b0:Q_reg <= Q_reg;
        2'b01:Q_reg <= R;
        2'b10:Q_reg <= w;
        2'b11:Q_reg <= R;
        default:Q_reg <= Q_reg;
    endcase
end
assign Q = Q_reg;
endmodule