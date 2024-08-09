`include "./FSMs/moore.v"
`include "./FSMs/mealy.v"

module top (
    clk,
    front_sensor,
    left_sensor,
    front,
    turn
);
    input clk, front_sensor, left_sensor;
    output front, turn;

    mealy FSM(clk, front_sensor, left_sensor, front, turn);
endmodule
