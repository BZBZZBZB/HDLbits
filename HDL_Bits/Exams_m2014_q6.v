module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);
reg [2:0] nstate;
reg [2:0] cstate;
reg z_reg;

always @(posedge clk)begin
    if(reset)begin
        cstate <= 3'b0;
    end
    else begin
        cstate <= nstate;
    end
end

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

always @(*)begin
    nstate = A;
    case (cstate)
        A:begin
            nstate = w ? A : B;
            z_reg = 1'b0;
        end
        B:begin
            nstate = w ? D : C;
            z_reg = 1'b0;
        end
        C:begin
            nstate = w ? D : E;
            z_reg = 1'b0;
        end
        D:begin
            nstate = w ? A : F;
            z_reg = 1'b0;
        end
        E:begin
            nstate = w ? D : E;
            z_reg = 1'b1;
        end
        F:begin
            nstate = w ? D : C;
            z_reg = 1'b1;
        end
        default:nstate = A;
    endcase
end
assign z = z_reg;
endmodule