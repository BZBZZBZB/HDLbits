module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q); 
always @(posedge clk)begin
    if(load)begin
        q <= data;
    end
    else if (ena) begin
        case (amount)
            2'd0:q <= {q[62:0],1'b0};
            2'd1:q <= {q[55:0],8'b0};
            2'd2:q <= {q[63],q[63:1]};
            2'd3:q <= {{8{q[63]}},q[63:8]};
            default: q <= q;    
        endcase
    end
    else begin
        q <= q;
    end
end
endmodule