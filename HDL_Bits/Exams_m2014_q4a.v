module top_module (
    input d, 
    input ena,
    output q);
    // reg q_reg;
    // always @(*)begin
    //     if(ena)begin
    //         q_reg = d;
    //     end
    // end
    // assign q = q_reg;
    //这个也会出现锁存器
    assign q = ena ? d : q;
endmodule