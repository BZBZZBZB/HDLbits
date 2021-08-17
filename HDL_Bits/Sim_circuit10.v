module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    reg state_reg;

      always@(posedge clk)begin
        if(a == b)begin
        	state_reg <= a;
        end
    end
    
    //always @(posedge clk) state_reg <= state_reg ? a|b : a&b;
    assign q = a^b^state;
    assign state = state_reg;
endmodule