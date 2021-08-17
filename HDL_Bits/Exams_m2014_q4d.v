module top_module (
    input clk,
    input in, 
    output out);
wire d_wire;
reg q_reg;

always @(posedge clk)begin
    q_reg <= d_wire;
end
assign d_wire = in ^ q_reg;
assign out = q_reg;
endmodule
