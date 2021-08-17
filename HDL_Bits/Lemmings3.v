module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    reg walk_left_reg;
    reg walk_right_reg;
    reg aaah_reg;
    reg digging_reg;

    reg [5:0] cstate;
    reg [5:0] nstate;

    parameter s1 = 6'b000001;//正常往左走
    parameter s2 = 6'b000010;//正常往右走
    parameter s3 = 6'b000100;//掉落后往左走
    parameter s4 = 6'b001000;//掉落后往右走
    parameter s5 = 6'b010000;//左边走开始挖路
    parameter s6 = 6'b100000;//右边走开始挖路

    always @(posedge clk or posedge areset)begin
        if(areset)begin
            cstate <= s1;
        end
        else begin
            cstate <= nstate;
        end
    end

    always @(*)begin
        nstate = s1;
        case (cstate)
            s1:begin
                if(ground)begin
                    if(~aaah && dig)begin
                        nstate = s5;
                    end
                    else if(bump_left) begin
                        nstate = s2;
                    end
                    else begin
                        nstate = s1;
                    end
                end
                else begin
                    nstate = s3;
                end
                walk_left_reg = 1'b1;
                walk_right_reg = 1'b0;
                aaah_reg = 1'b0;
                digging_reg = 1'b0;
            end

            s2:begin
                if(ground)begin
                    if(~aaah && dig)begin
                        nstate = s6;
                    end
                    else if(bump_right) begin
                        nstate = s1;
                    end
                    else begin
                        nstate = s2;
                    end
                end
                else begin
                    nstate = s4;
                end
                walk_left_reg = 1'b0;
                walk_right_reg = 1'b1;
                aaah_reg = 1'b0;
                digging_reg = 1'b0;
            end

            s3:begin
                if(ground)begin
                    nstate = s1;
                end
                else begin
                    nstate = s3;
                end
                walk_left_reg = 1'b0;
                walk_right_reg = 1'b0;
                aaah_reg = 1'b1;
                digging_reg = 1'b0;
            end

            s4:begin
                if(ground)begin
                    nstate = s2;
                end
                else begin
                    nstate = s4;
                end
                walk_left_reg = 1'b0;
                walk_right_reg = 1'b0;
                aaah_reg = 1'b1;
                digging_reg = 1'b0;
            end

            s5:begin
                if(ground)begin
                    nstate = s5;
                end
                else begin
                    nstate = s3;
                end
                walk_left_reg = 1'b0;
                walk_right_reg = 1'b0;
                aaah_reg = 1'b0;
                digging_reg = 1'b1;
            end

            s6:begin
                if(ground)begin
                    nstate = s6;
                end
                else begin
                    nstate = s4;
                end
                walk_left_reg = 1'b0;
                walk_right_reg = 1'b0;
                aaah_reg = 1'b0;
                digging_reg = 1'b1;
            end
            
            default:begin
                nstate = s1;
            end
        endcase
    end

    assign walk_left = walk_left_reg;
    assign walk_right = walk_right_reg;
    assign digging = digging_reg;
    assign aaah = aaah_reg;

endmodule