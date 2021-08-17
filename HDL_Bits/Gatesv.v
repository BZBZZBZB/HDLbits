module top_module( 
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different );
    
integer i;
reg [2:0] out_both_reg;
reg [3:1] out_any_reg;
reg [2:0] out_different_reg;
//闭环部分单独进行计算
wire out_different_wire;

always @(*)begin
    for(i = 0; i < 3;i = i + 1)begin
        if(in[i] == 1 && in[i + 1])begin
            out_both_reg[i] = 1;
        end
        else begin
            out_both_reg[i] = 0;
        end
    end
end

always @(*)begin
    for(i = 1; i < 4;i = i + 1)begin
        if(in[i] == 1 || in[i - 1])begin
            out_any_reg[i] = 1;
        end
        else begin
            out_any_reg[i] = 0;
        end
    end
end

always @(*)begin
    for(i = 0; i < 3;i = i + 1)begin
        if(in[i] == 1 != in[i + 1])begin
            out_different_reg[i] = 1;
        end
        else begin
            out_different_reg[i] = 0;
        end
    end
end

assign out_different_wire = (in[3] != in[0]) ? 1 : 0;
assign out_both = out_both_reg;
assign out_any = out_any_reg;
assign out_different = {out_different_wire,out_different_reg};
endmodule