`include "./FSMs/moore.v"
`include "./FSMs/mealey.v"

module top (
    clk,
    front_sensor,
    left_sensor,
    front,
    turn
);
    input clk, front_sensor, left_sensor;
    output front, turn;

    mealey mealey_FSM(clk, front_sensor, left_sensor, front, turn);

endmodule
