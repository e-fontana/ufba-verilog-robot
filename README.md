# ENGC40 - Robô seguidor de muro em Verilog - Projeto individual II

Discente: Eduardo Lazarini Fontana

Matrícula: 223116028

# 1. Desenvolvimento do projeto

Na concepção do projeto do robô seguidor de muro em verilog, foi utilizado como base o projeto individual 1.

Os requisitos projeto são: 

- 1 divisor de frequência
- 1 solução com a máquina de estados de mealy
- 1 solução com a máquina de estados de moore
- 1 código testbench que constate o êxito do projeto

Para isso, foram utilizados os slides de sala de aula e as tabelas verdade de Mealy e Moore do projeto anterior.

# 2. Divisor de frequência

Na construção do divisor de frequência, como não foi definido especificamente um valor de entrada da frequência, esse valor é facilmente mutável e adaptável, pois o módulo responsável por dividir a frequência recebe um valor no parâmetro referente à frequência que recebe, porém, foi utilizado o valor padrão 50MHz.

```verilog
module frequency_divisor #(parameter clk_frequency = 50000000) (clk_50, clk);
    input clk_50;
    output reg clk = 0;

    reg [3:0] counter;

    always @(posedge clk_50) begin
        if (counter < clk_frequency - 1) begin
            counter <= counter + 1;
        end else begin
            counter <= 0;
            clk <= ~clk;
        end
    end
endmodule
```

Para o testbench do divisor de frequência, foi utilizado o valor de teste de 500hz, o clock da placa foi chamado de “clock50” e o clock do sistema foi chamado de “clock”, segue parte do código:

```verilog
module test;
    wire clk;
    reg clk50;

    integer i;
    parameter clk_frequency = 8;

    frequency_divisor #(clk_frequency) FD(clk50, clk);

    always @(clk) display;

    initial begin
        clk50 = 0;
        for (i = 0; i < clk_frequency * 4; i = i + 1) begin
            change_clock;
        end
        #1 $finish;
    end
  
    task display;
        #1 $display("clk: %b", clk);
    endtask

    task change_clock;
        #1 clk50 = ~clk50;
    endtask
endmodule

```

Assim, esperamos que haja a mudança de clock 2x no nosso sistema, como podemos observar na saída:

```verilog
clk: 0
clk: 1
clk: 0
frequency_divisor/testbench.v:19: $finish called at 33 (1s)
```

Podemos observar a saída correspondendo com a espectativa, sendo o primeiro valor o valor inicial do clock, sendo alterado 2x.

# 3. Máquina de Moore

Para a confecção do código da Máquina de Estados de Moore, foi utilizada a tabela verdade do projeto individual 1:

![Screenshot from 2024-08-11 20-50-44.png](ENGC40%20-%20Robo%CC%82%20seguidor%20de%20muro%20em%20Verilog%20-%20Proje%20e6e17fe08e224fb386312d39e76d9220/Screenshot_from_2024-08-11_20-50-44.png)

Assim, para iniciarmos o código, criamos os parâmetros para cada estado no código, o estado atual e o estado futuro:

```verilog
module moore(clk, front_sensor, left_sensor, front, turn);
    input clk, front_sensor, left_sensor;
    output front, turn;
    
    parameter NoEntry = 2'b00,
     LeftEntry = 2'b01,
     FrontEntry = 2'b10,
     BothEntry = 2'b11;
     
    reg [1:0] state, next_state;
```

Depois disso, criamos um laço always que inputa o estado futuro no estado atual a cada vez que o clock é alterado e, como não precisamos de um always para o decodificador de saída, podemos inputar os valores direto usando o assign, seguido com o nosso decodificador de próximo estado:

```verilog
 		always @(negedge clk) state <= next_state;
 		
 		assign front = (state == LeftEntry) | (state == NoEntry);
    assign turn = (state == FrontEntry) | (state == BothEntry);

    always @(state or front_sensor or left_sensor)
    begin
        case (state)
            NoEntry: case ({front_sensor, left_sensor})
                2'b00: next_state = NoEntry;
                2'b01: next_state = LeftEntry;
                default: next_state = FrontEntry;
            endcase
            LeftEntry: case ({front_sensor, left_sensor})
                2'b01: next_state = LeftEntry;
                2'b11: next_state = FrontEntry;
                default: next_state = BothEntry;
            endcase
            FrontEntry: case ({front_sensor, left_sensor})
                2'b01: next_state = LeftEntry;
                default: next_state = FrontEntry;
            endcase
            default: next_state = NoEntry;
        endcase
    end
endmodule
```

# 4. Máquina de Mealy

Para a confecção do código da Máquina de Estados de Moore, foi utilizada a tabela verdade do projeto individual 1:

![Screenshot from 2024-08-11 21-11-15.png](ENGC40%20-%20Robo%CC%82%20seguidor%20de%20muro%20em%20Verilog%20-%20Proje%20e6e17fe08e224fb386312d39e76d9220/Screenshot_from_2024-08-11_21-11-15.png)

Assim, para iniciarmos o código, criamos os parâmetros para cada estado no código, o estado atual e o estado futuro:

```verilog
module mealy(clk, front_sensor, left_sensor, front, turn);
    input clk, front_sensor, left_sensor;
    output front, turn;
    
    reg front, turn;

    parameter NoEntry = 2'b00,
     LeftEntry = 2'b01,
     FrontEntry = 2'b10;

    reg [1:0] state = NoEntry, next_state;
```

Depois disso, criamos um laço always que inputa o estado futuro no estado atual a cada vez que o clock é alterado porém, como precisamos de um always para o decodificador de saída, não podemos inputar os valores direto usando o assign, seguido com o nosso decodificador de próximo estado e decodificador de saída:

```verilog
always @(posedge clk) state <= next_state;

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
            default: next_state = NoEntry;
        endcase
    end
endmodule
```

# 5. Módulo TOP

O módulo TOP é o módulo principal, foi criado para chamar todos os outros módulos da aplicação.

```verilog
`include "./moore.v"
`include "./mealy.v"
`include "./frequency_divisor.v"

module top #(parameter clk_frequency = 8)(
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
  
  	// Para testar as máquinas, basta alternar a linha comentada.
    //mealy FSM(clk, front_sensor, left_sensor, front, turn);
    moore FSM(clk, front_sensor, left_sensor, front, turn);

endmodule
```

# 6. Testbench

Para construir o testbench, foram criadas as entradas de acordo com o mapa apresentado no PDF da primeira atividade

```verilog
module test;
  wire front, turn, clk;
  reg clk50, front_sensor, left_sensor;

  parameter clk_frequency = 8;

  top #(clk_frequency) TOP(.clk(clk), .clk50(clk50), .front_sensor(front_sensor),
          .left_sensor(left_sensor), .front(front), .turn(turn));

  always #1 clk50 <= ~clk50;

  initial begin
    clk50 = 1'b0; front_sensor = 1'b0; left_sensor = 1'b0;
    // Entradas no PDF omitidas para facilitar a visualização.
    #1 $finish;
  end

  task display;
    $display("front_sensor: %0h, left_sensor: %0h, front: %0h, turn: %0h",
     front_sensor, left_sensor, front, turn);
  endtask

  task step(input [1:0] f_sensor, l_sensor);
    begin
      #(clk_frequency) begin
        front_sensor = f_sensor;
        left_sensor = l_sensor;
      end
      #(clk_frequency * 3) display;
    end
  endtask
endmodule
```

No módulo do Testbench, é alterado a cada 1 instante o clock, tasks de apoio para evitar a repetição do código e declarados os valores padrões de entrada que viriam da placa/sensores. Como resultado, temos um csv com as saídas para mealy e moore a cada task.

## 6.1. Teste de Moore

Temos como saída:

```verilog
front_sensor: 0, left_sensor: 0, front: 1, turn: 0
front_sensor: 0, left_sensor: 0, front: 1, turn: 0
front_sensor: 1, left_sensor: 0, front: 0, turn: 1
// ...
front_sensor: 0, left_sensor: 0, front: 0, turn: 1
front_sensor: 0, left_sensor: 1, front: 1, turn: 0
test/testbench.v:115: $finish called at 3169 (1s)
```

Utilizando um código Pyrhon para auxiliar o teste, podemos verificar visualmente o êxito do código esctito:

![Screenshot from 2024-08-11 21-21-30.png](ENGC40%20-%20Robo%CC%82%20seguidor%20de%20muro%20em%20Verilog%20-%20Proje%20e6e17fe08e224fb386312d39e76d9220/Screenshot_from_2024-08-11_21-21-30.png)

## 6.2. Teste de Mealy

Para Mealy, seguimos a mesma lógica:

```verilog
front_sensor: 0, left_sensor: 0, front: 1, turn: 0
front_sensor: 0, left_sensor: 0, front: 1, turn: 0
front_sensor: 1, left_sensor: 0, front: 0, turn: 1
// ...
front_sensor: 0, left_sensor: 0, front: 0, turn: 1
front_sensor: 0, left_sensor: 1, front: 1, turn: 0
test/testbench.v:115: $finish called at 3169 (1s)
```

![Screenshot from 2024-08-11 21-21-30.png](ENGC40%20-%20Robo%CC%82%20seguidor%20de%20muro%20em%20Verilog%20-%20Proje%20e6e17fe08e224fb386312d39e76d9220/Screenshot_from_2024-08-11_21-21-30.png)