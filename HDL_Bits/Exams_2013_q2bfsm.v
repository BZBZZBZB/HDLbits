module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
reg [3:0] nstate;
reg [3:0] cstate;
reg f_reg;
reg g_reg;

parameter s0 = 4'b0000;
parameter s1 = 4'b0001;
parameter s2 = 4'b0010;
parameter s3 = 4'b0011;
parameter s4 = 4'b0100;
parameter s5 = 4'b0101;
parameter s6 = 4'b0110;
parameter s7 = 4'b0111;
parameter s8 = 4'b1000;

always @(posedge clk)begin
    if(~resetn)begin
        cstate <= s0;
    end
    else begin
        cstate <= nstate;
    end
end

always @(*)begin
    nstate = s0;
    case (cstate)
        s0:begin
            nstate = resetn ? s1 : s0;
            f_reg = 1'b0;
            g_reg = 1'b0;
        end
        s1:begin
            nstate = s2;
            f_reg = 1'b1;
            g_reg = 1'b0;
        end
        s2:begin
            nstate = x ? s3 : s2;
            f_reg = 1'b0;
            g_reg = 1'b0;
        end
        s3:begin
            nstate = x ? s3 : s4;
            f_reg = 1'b0;
            g_reg = 1'b0;
        end
        s4:begin
            nstate = x ? s5 : s2;
            f_reg = 1'b0;
            g_reg = 1'b0;
        end
        s5:begin
            nstate = y ? s6 : s7;
            f_reg = 1'b0;
            g_reg = 1'b1;
        end
        s6:begin
            nstate = s6;
            f_reg = 1'b0;
            g_reg = 1'b1;
        end
        s7:begin
            nstate = y ? s6 : s8;
            f_reg = 1'b0;
            g_reg = 1'b1;
        end
        s8:begin
            nstate = s8;
            f_reg = 1'b0;
            g_reg = 1'b0;
        end
        default:nstate = s0;
    endcase
end

assign f = f_reg;
assign g = g_reg;
endmodule