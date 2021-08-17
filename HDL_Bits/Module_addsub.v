module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
wire [31:0] b_actually;
wire [15:0] sum_add1;
wire [15:0] sum_add2;
wire cout_add1;
wire cout_add2;
//取反加1
assign b_actually = sub == 1 ? (~b + 1) : b;

//module add16 ( input[15:0] a, input[15:0] b, input cin, output[15:0] sum, output cout );
add16 u_add16_1(
    .a(a[15:0]),
    .b(b_actually[15:0]),
    .cin(0),
    .sum(sum_add1),
    .cout(cout_add1)
);

add16 u_add16_2(
    .a(a[31:16]),
    .b(b_actually[31:16]),
    .cin(cout_add1),
    .sum(sum_add2),
    .cout(cout_add2)
);
assign sum = {sum_add2,sum_add1};
endmodule