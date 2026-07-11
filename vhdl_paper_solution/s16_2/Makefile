cc = ghdl 
cc2 = gtkwave 
top = s16_2 
testbench = s16_2_tb 
time = 500ns
wave_name = wave1
setting_name = setting1

all: 
	$(cc) -a $(top).vhd $(testbench).vhd 
	$(cc) -e $(testbench)
	$(cc) -r $(testbench) --stop-time=$(time) --wave=$(wave_name).ghw
	$(cc2) $(wave_name) $(setting_name).gtkw