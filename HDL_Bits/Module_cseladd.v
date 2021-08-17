module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

wire [15:0] sum_add1;
wire [15:0] sum_add2;
wire [15:0] sum_add3;

wire cout_add1;
wire cout_add2;
wire cout_add3;
//module add16 ( input[15:0] a, input[15:0] b, input cin, output[15:0] sum, output cout );
add16 u_add16_1(
    .a(a[15:0]),
    .b(b[15:0]),
    .cin(0),
    .sum(sum_add1),
    .cout(cout_add1)
);

add16 u_add16_2(
    .a(a[31:16]),
    .b(b[31:16]),
    .cin(0),
    .sum(sum_add2),
    .cout(cout_add2)
);

add16 u_add16_3(
    .a(a[31:16]),
    .b(b[31:16]),
    .cin(1),
    .sum(sum_add3),
    .cout(cout_add3)
);


assign sum = cout_add1 == 1 ? {sum_add3,sum_add1} : {sum_add2,sum_add1};
endmodule