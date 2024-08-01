
`include "design.v"

module test;
  reg clk, front_sensor, left_sensor;
  wire front, turn;
  
  top TOP(.clk(clk), .front_sensor(front_sensor),
          .left_sensor(left_sensor), .front(front), .turn(turn));

  initial begin
    clk = 1'b1;
    test_sensor(0,0);
    test_sensor(0,0);
    test_sensor(1,0);
    test_sensor(0,0);
    test_sensor(0,0);
    test_sensor(0,1);
    test_sensor(0,1);
    test_sensor(0,1);
    test_sensor(0,1);
    test_sensor(1,1);
    test_sensor(1,0);
    test_sensor(0,0);
    test_sensor(0,1);
    test_sensor(1,0);
    test_sensor(0,0);
    test_sensor(1,1);
    test_sensor(1,0);
    test_sensor(0,0);
    test_sensor(0,1);
    test_sensor(0,1);
    test_sensor(0,1);
  end
  
  task display;
    #1 $display("clk: %0h, front_sensor: %0h, left_sensor: %0h, front: %0h, turn: %0h",
     clk, front_sensor, left_sensor, front, turn);
  endtask

  task change_clock; begin
    #1 clk = ~clk;
    #2 clk = ~clk;
  end
  endtask

  task test_sensor(input [1:0] f_sensor, l_sensor);
    #1 begin
      front_sensor <= f_sensor;
      left_sensor <= l_sensor;
      change_clock;
      display;
    end
  endtask

endmodule