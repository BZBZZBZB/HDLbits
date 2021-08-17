module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);

reg [5:0] nstate;

parameter A = 6'b000001;
parameter B = 6'b000010;
parameter C = 6'b000100;
parameter D = 6'b001000;
parameter E = 6'b010000;
parameter F = 6'b100000;

always @(*)begin
    nstate = A;
    case (1)
        y[1]:nstate = w ? A : B;
        y[2]:nstate = w ? D : C;
        y[3]:nstate = w ? D : E;
        y[4]:nstate = w ? A : F;
        y[5]:nstate = w ? D : E;
        y[6]:nstate = w ? D : C;
        default:nstate = A;
    endcase
end
assign Y2 = nstate[1];
assign Y4 = nstate[3];
endmodule