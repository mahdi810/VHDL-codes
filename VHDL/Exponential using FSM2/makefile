#tool paths 
GHDL = ghdl 
GTKWAVE = gtkwave 

# project setting 
TOP = fsmexp 
TB = fsmexp_tb 
WAVE = wave.ghw 
WAVEPLOT = wave_plot.gtkw
STOPTIME = 500ns

#source files 
SRCS = fsmexp.vhd fsmexp_tb.vhd 

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