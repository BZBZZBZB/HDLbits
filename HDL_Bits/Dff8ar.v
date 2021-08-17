module top_module (
    input clk,
    input areset,   // active high asynchronous reset
    input [7:0] d,
    output [7:0] q
);
reg [7:0] q_reg;
//如果异步复位用的是复位信号的下降沿，只能是低有效，如果异步复位用的是复位信号的上升沿，只能是高有效
always @(posedge clk , posedge areset)begin
    if(areset)begin
        q_reg <= 0;
    end
    else begin
        q_reg <= d;
    end
end

assign q = q_reg;
endmodule