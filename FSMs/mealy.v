module mealy(clk, front_sensor, left_sensor, front, turn);
    input clk, front_sensor, left_sensor;
    output front, turn;

    reg front, turn;

    parameter NoEntry = 2'b00,
     LeftEntry = 2'b01,
     FrontEntry = 2'b10;

    reg [1:0] state, next_state;

    always @(posedge clk) state <= next_state;

    always @(state or front_sensor or left_sensor)
    begin
        case (state)
            NoEntry: case ({front_sensor, left_sensor})
                2'b01: begin
                    front <= 1'b1;
                    turn <= 1'b0;
                    next_state <= LeftEntry;
                end
                2'b10: begin
                    front <= 1'b0;
                    turn <= 1'b1;
                    next_state <= FrontEntry;
                end
                2'b11: begin
                    front <= 1'b0;
                    turn <= 1'b1;
                    next_state <= FrontEntry;
                end
                default: begin
                    front <= 1'b1;
                    turn <= 1'b0;
                    next_state <= NoEntry;
                end
            endcase
            LeftEntry: case ({front_sensor, left_sensor})
                2'b01: begin
                    front <= 1'b1;
                    turn <= 1'b0;
                    next_state <= LeftEntry;
                end
                2'b11: begin
                    front <= 1'b0;
                    turn <= 1'b1;
                    next_state <= FrontEntry;
                end
                default: begin
                    front <= 1'b0;
                    turn <= 1'b1;
                    next_state <= NoEntry;
                end
            endcase
            FrontEntry: case ({front_sensor, left_sensor})
                2'b01: begin
                    front <= 1'b1;
                    turn <= 1'b0;
                    next_state <= LeftEntry;
                end
                2'b11: begin
                    front <= 1'b0;
                    turn <= 1'b1;
                    next_state <= FrontEntry;
                end
                default: begin
                    front <= 1'b0;
                    turn <= 1'b1;
                    next_state <= FrontEntry;
                end
            endcase
            default: next_state <= NoEntry;
        endcase
    end

endmodule