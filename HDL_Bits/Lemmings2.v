module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 

    reg walk_left_reg;
    reg walk_right_reg;
    reg aaah_reg;

    reg [3:0] nstate;
    reg [3:0] cstate;
    parameter s1 = 4'b0001;//有地面往左走
    parameter s2 = 4'b0010;//有地面往右走
    parameter s3 = 4'b0100;//没有地面往左走
    parameter s4 = 4'b1000;//没有地面往右走

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
                    if(bump_left)begin
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
            end

            s2:begin
                if(ground)begin
                    if(bump_right)begin
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
            end
            default:begin
                nstate = s1;
            end
        endcase
    end
    assign walk_left = walk_left_reg;
    assign walk_right = walk_right_reg;
    assign aaah = aaah_reg;

endmodule