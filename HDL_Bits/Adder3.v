module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
reg [3:0] cout_reg;
reg [2:0] sum_reg;

integer i;
always @(*)begin
    cout_reg[0] = cin;
    for(i = 0; i < 3;i = i + 1)begin
        cout_reg[i + 1] = (a[i] & b[i]) | (a[i] & cout_reg[i]) | (b[i] & cout_reg[i]); 
        sum_reg[i] = a[i] ^ b[i] ^ cout_reg[i];
    end
end

assign cout = cout_reg[3:1];
assign sum = sum_reg;
endmodule