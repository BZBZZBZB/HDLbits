module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
reg [7:0] pedge_reg;
reg [7:0] in_reg;
integer i;

    always @(posedge clk)begin
        in_reg <= in;
    end

    always @(posedge clk) begin
        for(i = 0; i < 8;i = i + 1)begin
            if(~in_reg[i] && in[i])begin
                pedge_reg[i] <= 1;
            end
            else begin
                pedge_reg[i] <= 0;
            end
        end
    end

assign pedge = pedge_reg;
endmodule