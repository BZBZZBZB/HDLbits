module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); 

wire [3:0] one , ten , hundred;
//这里面的1要写成1'b1，否则会认为是32位的1，位宽不匹配
assign c_enable = {ten == 4'd9 && one == 4'd9, one == 4'd9,1'b1};
assign OneHertz = one == 4'd9 && ten == 4'd9 && hundred == 4'd9;

bcdcount u_bcdcount_one(
    .clk(clk),
    .reset(reset),
    .enable(1),
    .Q(one)
);

bcdcount u_bcdcount_ten(
    .clk(clk),
    .reset(reset),
    .enable(c_enable[1]),
    .Q(ten)
);

bcdcount u_bcdcount_hundred(
    .clk(clk),
    .reset(reset),
    .enable(c_enable[2]),
    .Q(hundred)
);
endmodule

// module bcdcount (
// 	input clk,
// 	input reset,
// 	input enable,
// 	output reg [3:0] Q
// );