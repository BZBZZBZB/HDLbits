module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
reg in_delay1;
reg in_delay2;
reg in_delay3;
reg in_delay4;

always @(posedge clk)begin
    if(~resetn)begin
        in_delay1 <= 0;
        in_delay2 <= 0;
        in_delay3 <= 0;
        in_delay4 <= 0;
    end
    else begin
        in_delay1 <= in;
        in_delay2 <= in_delay1;
        in_delay3 <= in_delay2;
        in_delay4 <= in_delay3;
    end
end
assign out = in_delay4;
endmodule