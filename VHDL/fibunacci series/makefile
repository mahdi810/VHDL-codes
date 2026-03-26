#tool paths 
GHDL = ghdl 
GTKWAVE = gtkwave 

# project setting 
TOP = fibs 
TB = fibs_tb 
WAVE = wave.ghw 
WAVEPLOT = wave_setting.gtkw
STOPTIME = 500ns

#source files 
SRCS = fibs.vhd fibs_tb.vhd 

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