module top_module (
    input clk,
    input x,
    output z
); 
reg q1_reg;
reg q2_reg;
reg q3_reg;

always @(posedge clk)begin
    q1_reg <= q1_reg ^ x;
end

always @(posedge clk)begin
    q2_reg <= ~q2_reg & x;
end

always @(posedge clk)begin
    q3_reg <= !q3_reg | x;
end
assign z = !(q1_reg | q2_reg | q3_reg);
endmodule