module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
reg [7:0] in_reg;
reg [7:0] anyedge_reg;
integer i;

always @(posedge clk) begin
    in_reg <= in;
end

always @(posedge clk) begin
    for(i = 0; i < 8;i = i + 1)begin
        if(in[i] != in_reg[i])begin
            anyedge_reg[i] <= 1;
        end
        else begin
            anyedge_reg[i] <= 0;
        end
    end
end
assign anyedge = anyedge_reg;
endmodule