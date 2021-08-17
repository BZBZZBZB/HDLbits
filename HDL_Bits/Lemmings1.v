module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    // parameter LEFT=0, RIGHT=1, ...
    reg walk_left_reg;
    reg walk_right_reg;
    reg state, next_state;
    parameter S1 = 1'b0;//往左走
    parameter S2 = 1'b1;//往右走
    always @(*) begin
        // State transition logic
         case (state)
            S1:begin
                if(bump_left)begin
                    next_state = S2;
                end
                else begin
                    next_state = S1;
                end
                walk_left_reg = 1'b1;
                walk_right_reg = 1'b0;
            end
            S2:begin
                if(bump_right)begin
                    next_state = S1;
                end
                else begin
                    next_state = S2;
                end
                walk_left_reg = 1'b0;
                walk_right_reg = 1'b1;
            end
            default:begin
                next_state = S1;
                walk_left_reg = walk_left_reg;
                walk_right_reg = walk_right_reg;
            end
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset)begin
            state <= S1;
    end
        else begin
            state <= next_state;
        end
    end
    // Output logic
    // assign walk_left = (state == ...);
    // assign walk_right = (state == ...);
    assign walk_left = walk_left_reg;
    assign walk_right = walk_right_reg;

endmodule