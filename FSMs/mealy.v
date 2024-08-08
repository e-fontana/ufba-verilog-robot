module mealy(clk, front_sensor, left_sensor, front, turn);
    input clk, front_sensor, left_sensor;
    output front, turn;

    reg front, turn;

    parameter NoEntry = 2'b00,
     LeftEntry = 2'b01,
     FrontEntry = 2'b10;

    reg [1:0] state, next_state;

    always @(negedge clk) begin
        // $display("state: %b, next_state: %b", state, next_state);
        state <= next_state;
    end

    always @(state or front_sensor or left_sensor)
    begin
        case (state)
            NoEntry: case ({front_sensor, left_sensor})
                2'b01: begin
                    next_state = LeftEntry;
                    front = 1'b1;
                    turn = 1'b0;
                end
                2'b10: begin
                    next_state = FrontEntry;
                    front = 1'b0;
                    turn = 1'b1;
                end
                2'b11: begin
                    next_state = FrontEntry;
                    front = 1'b0;
                    turn = 1'b1;
                end
                default: begin
                    next_state = NoEntry;
                    front = 1'b1;
                    turn = 1'b0;
                end
            endcase
            LeftEntry: case ({front_sensor, left_sensor})
                2'b00: begin
                    next_state = NoEntry;
                    front = 1'b0;
                    turn = 1'b1;
                end
                2'b01: begin
                    next_state = LeftEntry;
                    front = 1'b1;
                    turn = 1'b0;
                end
                2'b11: begin
                    next_state = FrontEntry;
                    front = 1'b0;
                    turn = 1'b1;
                end
                default: begin
                    next_state = NoEntry;
                    front = 1'b0;
                    turn = 1'b1;
                end
            endcase
            FrontEntry: case ({front_sensor, left_sensor})
                2'b01: begin
                    next_state = LeftEntry;
                    front = 1'b1;
                    turn = 1'b0;
                end
                2'b11: begin
                    next_state = FrontEntry;
                    front = 1'b0;
                    turn = 1'b1;
                end
                default: begin
                    next_state = FrontEntry;
                    front = 1'b0;
                    turn = 1'b1;
                end
            endcase
            default: begin
                front = 1'b1;
                turn = 1'b0;
                next_state = NoEntry;
            end
        endcase
    end

endmodule