module top_module (input a, input b, input c, output out);//

    wire out_wire;
    andgate inst1 ( out_wire,a, b, c,1,1 );
    
assign out = ~out_wire;

endmodule
