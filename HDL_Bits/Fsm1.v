module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=0, B=1; 
    reg state, next_state;
    reg out_reg;

    always @(*) begin    // This is a combinational always block
        // State transition logic
        next_state = B;
        case (state)
            B:begin
                if(in)begin
                    next_state = B;
                end
                else  begin
                    next_state = A;
                end
                out_reg = 1'b1;
            end
            A:begin
                if(in)begin
                    next_state = A;
                end
                else begin
                    next_state = B;
                end
                out_reg = 1'b0;
            end
            default:out_reg <= 1'b1;
        endcase
    end

    always @(posedge clk, posedge areset) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if(areset)begin
            state <= B;
        end
        else begin
            state <= next_state;
        end
    end

    // Output logic
    // assign out = (state == ...);
    assign out = out_reg;
endmodule