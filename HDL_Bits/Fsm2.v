module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;
    reg out_reg;

    always @(*) begin
        // State transition logic
        next_state  = OFF;
        case (state)
            OFF:begin
                if(j)begin
                    next_state = ON;
                end
                else if(~j)begin
                    next_state = OFF;
                end
                else begin
                    next_state <= next_state;
                end
                out_reg = 1'b0;
            end
            ON:begin
                if(k)begin
                    next_state = OFF;
                end
                else if(~k)begin
                    next_state = ON;
                end
                else begin
                    next_state <= next_state;
                end
                out_reg = 1'b1;
            end
            default:out_reg = 1'b1;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset)begin
            state <= OFF;            
        end
        else begin
            state <= next_state;
        end
    end

    // Output logic
    // assign out = (state == ...);
    assign out = out_reg;

endmodule