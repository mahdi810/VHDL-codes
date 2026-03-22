#tool paths 
GHDL = ghdl 
GTKWAVE = gtkwave 

# project setting 
TOP = clkdiv 
TB = clkdiv_tb 
WAVE = wave.ghw 
WAVEPLOT = wave_plot.gtkw
STOPTIME = 2000ns

#source files 
SRCS = clkdiv.vhd clkdiv_tb.vhd 

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