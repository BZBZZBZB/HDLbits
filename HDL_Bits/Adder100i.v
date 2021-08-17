module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );

    assign sum[0] = a[0] ^ b[0] ^ cin;
    assign cout[0] = (a[0] & b[0]) | (a[0] & cin) | (b[0] & cin);

    
    generate
        genvar i;
        //这里，for循环后面一定要跟一个描述性的话，不然会报错，不知道为什么
        for ( i=1;i < 100; i = i + 1) begin:ADD
    //这里要使用assign,不然会报错,sum类型不确定
            assign sum[i] = a[i] ^ b[i] ^ cout[i - 1];
            assign cout[i] = (a[i] & b[i]) | (a[i] & cout[i-1]) | (b[i] & cout[i-1]);

        end
    endgenerate

endmodule


