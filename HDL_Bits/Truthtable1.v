module top_module( 
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);
//题目中的意思，其实可以化简，有点忘了，就不化简了
//网上的答案 ：assign f = (!x3 & x2) | (x3 & x1);
assign f = (~x3 & x2 & ~x1) | (~x3 & x2 & x1) | (x1 & ~x2 & x3) | (x1 & x2 & x3);

endmodule