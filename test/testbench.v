`include "./design.v"

module test;
  reg clk, front_sensor, left_sensor;
  wire front, turn;

  top TOP(.clk(clk), .front_sensor(front_sensor),
          .left_sensor(left_sensor), .front(front), .turn(turn));

  always #1 clk <= ~clk;

  initial begin
    clk = 1'b0; front_sensor = 1'b0; left_sensor = 1'b0;
    step(0,0);
    step(0,0);
    step(1,0);
    step(0,0);
    step(0,0);
    step(0,1);
    step(0,1);
    step(0,1);
    step(0,1);
    step(1,1);
    step(1,0);
    step(0,0);
    step(0,1);
    step(1,0);
    step(0,0);
    step(1,1);
    step(1,0);
    step(0,0);
    step(0,1);
    step(0,1);
    step(0,1);
    step(0,0);
    step(0,0);
    step(0,1);
    step(0,0);
    step(0,0);
    step(1,1);
    step(1,0);
    step(0,0);
    step(0,1);
    step(0,1);
    step(0,1);
    step(0,1);
    step(1,1);
    step(1,0);
    step(0,1);
    step(0,0);
    step(0,0);
    step(0,1);
    step(1,1);
    step(1,0);
    step(0,0);
    step(0,1);
    step(1,1);
    step(1,0);
    step(0,0);
    step(0,1);
    step(0,0);
    step(0,0);
    step(0,1);
    step(0,1);
    step(0,0);
    step(0,0);
    step(1,1);
    step(1,0);
    step(0,0);
    step(0,1);
    step(0,1);
    step(0,1);
    step(1,1);
    step(1,0);
    step(0,0);
    step(0,1);
    step(0,1);
    step(1,1);
    step(1,0);
    step(0,1);
    step(0,1);
    step(1,0);
    step(0,0);
    step(0,1);
    step(0,0);
    step(0,0);
    step(0,1);
    step(0,1);
    step(0,1);
    step(1,0);
    step(0,0);
    step(0,1);
    step(0,1);
    step(0,1);
    step(0,0);
    step(0,0);
    step(0,1);
    step(1,1);
    step(1,0);
    step(0,0);
    step(0,1);
    step(0,1);
    step(1,1);
    step(1,0);
    step(0,0);
    step(0,1);
    step(0,1);
    step(0,1);
    step(1,1);
    step(1,0);
    step(0,0);
    step(0,1);
    #1 $finish;
  end
  
  task display;
    $display("front_sensor: %0h, left_sensor: %0h, front: %0h, turn: %0h",
     front_sensor, left_sensor, front, turn);
  endtask
  task step(input [1:0] f_sensor, l_sensor);
    begin
      #1 begin
        front_sensor = f_sensor;
        left_sensor = l_sensor;
      end
      #1 display;
    end
  endtask

endmodule