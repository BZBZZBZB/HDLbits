module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); //
wire [8:0] a_wire;
wire [8:0] b_wire;
wire [8:0] s_wire;

assign a_wire = {a[7],a};
assign b_wire = {b[7],b};
assign s_wire = a_wire + b_wire;

assign s = s_wire[7:0];
assign overflow = s_wire[8] ^ s_wire[7];
    // assign s = ...
    // assign overflow = ...

endmodule