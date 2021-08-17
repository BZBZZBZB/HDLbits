module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
reg [2 : 0] nstate;
reg [2 : 0] cstate;
reg z_reg;
parameter IDLE = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;


always @(*)begin
    nstate = IDLE;
    case(y)
    IDLE:begin
        nstate = x ? S1 : IDLE;
        z_reg = 1'b0;
    end
    S1:begin
        nstate = x ? S4 : S1;
        z_reg = 1'b0;
    end
    S2:begin
        nstate = x ? S1 : S2;
        z_reg = 1'b0;
    end
    S3:begin
        nstate = x ? S2 : S1;
        z_reg = 1'b1;
    end
    S4:begin
        nstate = x ? S4 : S3;
        z_reg = 1'b1;
    end
    default:
        nstate = IDLE;
  endcase
end
assign z = z_reg;
assign Y0 = nstate[0];

endmodule