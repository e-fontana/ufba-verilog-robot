`include "./FSMs/moore.v"
`include "./frequency_divisor/design.v"


module moore_top #(parameter clk_frequency = 8)(
    clk,
    clk50,
    front_sensor,
    left_sensor,
    front,
    turn
);
    input clk50, front_sensor, left_sensor;
    output front, turn, clk;

    frequency_divisor #(clk_frequency) FD(.clk_50(clk50), .clk(clk));

    moore FSM(clk, front_sensor, left_sensor, front, turn);
endmodule
