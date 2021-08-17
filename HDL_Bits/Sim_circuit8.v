module top_module (
    input clock,
    input a,
    output p,
    output q );
    reg q_reg;
    reg p_reg;
    
    always@(*)begin
        if(clock)begin
        	p_reg = a;
        end
    end
    
    always@(negedge clock)begin
        q_reg <= p;
    end
 assign q = q_reg;
 assign p = p_reg;
endmodule