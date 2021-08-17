module top_module();
reg [2:0] s;
reg in;
reg clk;
wire out;
wire period;
parameter  cycle = 10;
initial begin
    clk = 0;
    in = 0;
    s = 2;
    #cycle
    s = 6;
    #cycle
    in = 1;
    s = 2;
    #cycle
    s = 7;
    in = 0;
    #cycle
    s = 0;
    in = 1;
    #(cycle * 3)
    in = 0;
end

always #(cycle/2) clk = ~clk;
assign period = cycle << 1;  
q7 u_q7(
    .clk(clk),
    .in(in),
    .s(s),
    .out(out)
);

endmodule