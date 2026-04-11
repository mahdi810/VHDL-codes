GHDL = ghdl
GTKWAVE = gtkwave

TIME ?= 500
DIR ?= .
TOP ?= test
TB  ?= $(TOP)_tb

STOPTIME = $(TIME)ns
WAVE = wave.ghw
WAVESETTING = wave_setting.gtkw

run:
	cd "$(DIR)" && \
	$(GHDL) -a *.vhd && \
	$(GHDL) -e $(TB) && \
	$(GHDL) -r $(TB) --stop-time=$(STOPTIME) --wave=$(WAVE) && \
	$(GTKWAVE) $(WAVE) $(WAVESETTING)

clean:
	cd "$(DIR)" && \
	$(GHDL) --remove && \
	del /f /q $(WAVE) 2>nul || true

.PHONY: run clean