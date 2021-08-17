module top_module( 
    input a, b,
    output out_and,
    output out_or,
    output out_xor,
    output out_nand,
    output out_nor,
    output out_xnor,
    output out_anotb
);

assign out_and = a & b;
assign out_or = a | b;
assign out_xor = a ^ b;
//与非门
assign out_nand = ~(a & b);
//或非门
assign out_nor = ~(a | b);
//同或门(相当于异或非门)
assign out_xnor = ~(a ^ b);
//and_not gate
assign out_anotb = a & ~b;

endmodule