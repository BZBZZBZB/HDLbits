module top_module( 
    input [15:0] a, b, c, d, e, f, g, h, i,
    input [3:0] sel,
    output [15:0] out );

    localparam [15:0] def_num = 16'hffff;
    reg [15:0] out_reg;
    always @(*)begin
        case (sel)
            0:out_reg = a;
            1:out_reg = b;
            2:out_reg = c;
            3:out_reg = d;
            4:out_reg = e;
            5:out_reg = f;
            6:out_reg = g;
            7:out_reg = h;
            8:out_reg = i;
            default:out_reg = def_num;
        endcase
    end
    assign out = out_reg;

endmodule
