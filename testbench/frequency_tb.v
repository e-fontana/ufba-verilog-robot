module test;
    wire clk;
    reg clk50;

    integer i;
    parameter clk_frequency = 8;

    frequency_divisor #(clk_frequency) FD(clk50, clk);

    always @(posedge clk) display;

    initial begin
        clk50 = 0;
        for (i = 0; i < clk_frequency * 4; i = i + 1) change_clock;
        #1 $finish;
    end

    task display;
        #1 $display("clk: %b", clk);
    endtask

    task change_clock;
        #1 clk50 = ~clk50;
    endtask
endmodule
