module top_module(
    input clk,
    input reset,    // Synchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;
    reg out_reg;

    always @(*) begin
        // State transition logic
        next_state = 1'b0;
        case (state)
            OFF[0]:begin
                if(j)begin
                    next_state = ON[0];
                end
                else if(~j)begin
                     next_state = OFF[0];
                end
                else begin
                    next_state = next_state;
                end
                out_reg = 1'b0;
            end
            ON[0]:begin
                if(k)begin
                    next_state = OFF[0];
                end
                else if(~k)begin
                     next_state = ON[0];
                end
                else begin
                    next_state = next_state;
                end
                out_reg = 1'b1;
            end
            default:out_reg = 1'b0;
        endcase
    end

    always @(posedge clk) begin
        // State flip-flops with synchronous reset
        if(reset)begin
            state <= OFF[0];
        end
        else begin
            state <= next_state;
        end
    end

    // Output logic
    // assign out = (state == ...);
    assign out = out_reg;

endmodule