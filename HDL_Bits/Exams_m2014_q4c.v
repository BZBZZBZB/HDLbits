module top_module (
    input clk,
    input d, 
    input r,   // synchronous reset
    output q);
reg q_reg;

always @(posedge clk)begin
    if(r)begin
        q_reg <= 0;
    end
    else begin
        q_reg <= d;
    end
end
assign q = q_reg;
endmodule
