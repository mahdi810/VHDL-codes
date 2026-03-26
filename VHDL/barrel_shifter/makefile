#tool paths 
GHDL = ghdl 
GTKWAVE = gtkwave 

# project setting 
TOP = barrel_shifter 
TB = barrel_shifter_tb 
WAVE = wave.ghw 
WAVEPLOT = wave_setting.gtkw
STOPTIME = 500ns

#source files 
SRCS = barrel_shifter.vhd barrel_shifter_tb.vhd 

all : anaylaze elaborate simulate wave 

anaylaze : 
	$(GHDL) -a $(SRCS)

elaboarate: 
	$(GHDL) -e $(TB)

simulate: 
	$(GHDL) -r $(TB) --stop-time=$(STOPTIME) --wave=$(WAVE)

wave: 
	$(GTKWAVE) $(WAVE) $(WAVEPLOT)

# Windows-compatible clean
clean:
	$(GHDL) --remove
	del /f /q $(WAVE) 2>nul || true

.PHONY: all analyze elaborate simulate wave clean