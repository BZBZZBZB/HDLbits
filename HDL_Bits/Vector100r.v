module top_module( 
    input [99:0] in,
    output [99:0] out
);
//for循环要写在always块中，内部要用reg
reg [99:0] out_reg;
integer i;
always @(*)begin
    for ( i=0; i<100; i = i + 1) begin
    out_reg[i] = in[99 - i];
    end
end

assign out = out_reg;
endmodule