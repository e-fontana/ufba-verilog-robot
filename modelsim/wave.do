onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Mealy
add wave -noupdate /mealy_tb/front
add wave -noupdate /mealy_tb/turn
add wave -noupdate /mealy_tb/clk
add wave -noupdate /mealy_tb/clk50
add wave -noupdate /mealy_tb/front_sensor
add wave -noupdate /mealy_tb/left_sensor
add wave -noupdate -divider Moore
add wave -noupdate /moore_tb/front
add wave -noupdate /moore_tb/turn
add wave -noupdate /moore_tb/clk
add wave -noupdate /moore_tb/clk50
add wave -noupdate /moore_tb/front_sensor
add wave -noupdate /moore_tb/left_sensor
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
WaveRestoreCursors
quietly wave cursor active 0
configure wave -namecolwidth 212
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {2960 ps}
