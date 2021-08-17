module top_module (
    input ring,
    input vibrate_mode,
    output ringer,       // Make sound
    output motor         // Vibrate
);
reg motor_reg;
reg ringer_reg;
always @(*)begin
    if(ring)begin
        if(vibrate_mode)begin
            motor_reg = 1;
            ringer_reg = 0;
        end
        else begin
            ringer_reg = 1;
            motor_reg = 0;
        end
    end
    else begin
        motor_reg = 0;
        ringer_reg = 0;
    end
end
assign ringer = ringer_reg;
assign motor = motor_reg;

endmodule