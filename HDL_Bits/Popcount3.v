module top_module( 
    input [2:0] in,
    output [1:0] out );

    integer i;
    reg [1:0] out_reg;
    always @(*)begin
        out_reg = 0;
        for ( i=0; i<3; i = i + 1) begin
            if(in[i] == 1)begin
                out_reg = out_reg + 1;
            end
            else begin
                out_reg = out_reg;
            end
        end
    end

    assign out = out_reg;

    // reg [1:0] out_reg;

    // always @(*)begin
    //     case (in)
    //         0:out_reg = 0;
    //         1:out_reg = 1;
    //         2:out_reg = 1;
    //         3:out_reg = 2;
    //         4:out_reg = 1;
    //         5:out_reg = 2;
    //         6:out_reg = 2;
    //         7:out_reg = 3;
    //         default :
    //             out_reg = 0;
    //     endcase
    // end
    // assign out = out_reg;
endmodule
