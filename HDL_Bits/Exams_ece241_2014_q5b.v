module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
reg [1:0] cstate;
reg [1:0] nstate;

parameter A = 2'b01;
parameter B = 2'b10;

always @(posedge clk or posedge areset)begin
    if(areset)begin
        cstate <= A;
    end
    else begin
        cstate <= nstate;
    end
end

always @(*)begin
    nstate = A;
    case (cstate)
        A:nstate = x ? B :A;
        B:nstate = B;
        default:nstate = A;
    endcase
end

assign z = (cstate == A && x == 1'b1) || (cstate == B && x == 1'b0);


endmodule