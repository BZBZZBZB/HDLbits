module top_module( 
    input a, b, cin,
    output cout, sum );
    wire t1,t2,t3;
    assign t1 = a & b;
    assign t2 = a & cin;
    assign t3 = b & cin;
    assign sum = a ^ b ^ cin;
    assign cout = t1 | t2 | t3;

endmodule