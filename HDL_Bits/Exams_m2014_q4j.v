module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
reg [4:0] cout_reg;
reg [3:0] sum_reg;

integer i;
always @(*)begin
    cout_reg[0] = 0;
    for(i = 0; i < 4;i = i + 1)begin
        cout_reg[i + 1] = (x[i] & y[i]) | (x[i] & cout_reg[i]) | (y[i] & cout_reg[i]); 
        sum_reg[i] = x[i] ^ y[i] ^ cout_reg[i];
    end
end

assign sum = {cout_reg[4],sum_reg};
endmodule