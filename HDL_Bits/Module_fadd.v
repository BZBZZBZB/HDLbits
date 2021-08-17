//会自动使用一位加法器模块进行例化十六位加法器
module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);//
// module add16 ( input[15:0] a, input[15:0] b, input cin, output[15:0] sum, output cout );
wire [15:0] sum_add1;
wire [15:0] sum_add2;

wire cout_add1;
wire cout_add2;
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
    .cin(cout_add1),
    .sum(sum_add2),
    .cout(cout_add2)
);

assign sum = {sum_add2,sum_add1};
endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );

wire t1,t2,t3;
assign t1 = a & b;
assign t2 = a & cin;
assign t3 = b & cin;
// Full adder module here
assign sum = a^b^cin;
assign cout = t1 | t2 | t3;

endmodule