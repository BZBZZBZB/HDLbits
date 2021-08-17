module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
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
        y[0]:nstate = w ? B : A;
        y[1]:nstate = w ? C : D;
        y[2]:nstate = w ? E : D;
        y[3]:nstate = w ? F : A;
        y[4]:nstate = w ? E : D;
        y[5]:nstate = w ? C : D;
        default:nstate = A;
    endcase
end
assign Y1 = nstate[1];
assign Y3 = nstate[3];
endmodule