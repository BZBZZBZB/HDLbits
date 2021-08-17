module top_module (
    input [3:1] y,
    input w,
    output Y2);
reg [2:0] nstate;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

always @(*)begin
    nstate = A;
    case (y)
        A:nstate = w ? A : B;
        B:nstate = w ? D : C;
        C:nstate = w ? D : E;
        D:nstate = w ? A : F;
        E:nstate = w ? D : E;
        F:nstate = w ? D : C;
        default:nstate = A;
    endcase
end

assign Y2 = nstate[1];
endmodule