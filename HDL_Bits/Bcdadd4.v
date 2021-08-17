module top_module( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    reg[4:0] cout_reg;

    always @(*)begin
        cout_reg[0] = cin;
    end

    generate
    genvar i;
        for(i = 0;i < 4;i = i + 1)begin:BCD
            bcd_fadd u_bcd_fadd(
                .a(a[((i+1) * 4 - 1)-: 4]),
                .b(b[((i+1) * 4 - 1)-: 4]),
                .cin(cout_reg[i]),
                .cout(cout_reg[i + 1]),
                .sum(sum[((i+1) * 4 - 1)-: 4])
            );
        end
    endgenerate
    assign cout = cout_reg[4];

endmodule