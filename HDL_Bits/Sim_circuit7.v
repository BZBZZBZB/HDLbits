module top_module (
    input clk,
    input a,
    output q );
    reg q_reg;
    always @(posedge clk)begin
        if(a)begin
            q_reg <= 0;
        end
        else begin
            q_reg <= 1;
        end
    end
    assign q = q_reg;
endmodule