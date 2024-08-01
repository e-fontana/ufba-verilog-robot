module moore(clk, front_sensor, left_sensor, front, turn);
    input clk, front_sensor, left_sensor;
    output front, turn;
    
    parameter NoEntry = 2'b00,
     LeftEntry = 2'b01,
     FrontEntry = 2'b10,
     BothEntry = 2'b11;

    reg [1:0] state, next_state;

    always @(posedge clk) state <= next_state;

    assign front = (state == LeftEntry) | (state == NoEntry);
    assign turn = (state == FrontEntry) | (state == BothEntry);

    always @(state or front_sensor or left_sensor)
    begin
        case (state)
            NoEntry: case ({front_sensor, left_sensor})
                2'b00: next_state <= NoEntry;
                2'b01: next_state <= LeftEntry;
                2'b10: next_state <= FrontEntry;
                2'b11: next_state <= FrontEntry;
                default: next_state <= NoEntry;
            endcase
            LeftEntry: case ({front_sensor, left_sensor})
                2'b00: next_state <= BothEntry;
                2'b01: next_state <= LeftEntry;
                2'b10: next_state <= BothEntry;
                2'b11: next_state <= FrontEntry;
                default: next_state <= BothEntry;
            endcase
            FrontEntry: case ({front_sensor, left_sensor})
                2'b00: next_state <= FrontEntry;
                2'b01: next_state <= LeftEntry;
                2'b10: next_state <= FrontEntry;
                2'b11: next_state <= FrontEntry;
                default: next_state <= NoEntry;
            endcase
            default: next_state <= NoEntry;
        endcase
    end

endmodule