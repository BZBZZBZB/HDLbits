module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
reg [2:0] nstate;
reg [2:0] cstate;
reg z_reg;

parameter s0 = 3'b000;
parameter s1 = 3'b001;
parameter s2 = 3'b010;
parameter s3 = 3'b011;
parameter s4 = 3'b100;

always @(posedge clk)begin
    if(reset)begin
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
            nstate = x ? s1 : s0;
            z_reg = 0;
        end

        s1:begin
            nstate = x ? s4 : s1;
            z_reg = 0;
        end

        s2:begin
            nstate = x ? s1 : s2;
            z_reg = 0;
        end

        s3:begin
            nstate = x ? s2 : s1;
            z_reg = 1;
        end

        s4:begin
            nstate = x ? s4 : s3;
            z_reg = 1;
        end
        default:nstate = s0;
    endcase
end
assign z = z_reg;
endmodule