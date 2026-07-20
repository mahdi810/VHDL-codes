CC1      = ghdl
CC2      = gtkwave

# Pass the folder when calling make:  make DIR=path/to/folder
DIR      ?= .

SOURCES  = $(wildcard $(DIR)/*.vhd)
TOP      ?= $(basename $(notdir $(lastword $(SOURCES))))

.PHONY: all compile simulate view

all: compile simulate view

compile:
	$(CC1) -a --workdir=$(DIR) $(SOURCES)
	$(CC1) -e --workdir=$(DIR) $(TOP)

simulate:
	$(CC1) -r --workdir=$(DIR) $(TOP) --stop-time=10000ns --wave=$(DIR)/wave.ghw

view:
	$(CC2) $(DIR)/wave.ghw $(DIR)/gtkw_setting.gtkw

# clean:
# 	rm -f $(DIR)/*.cf $(DIR)/wave.ghw $(DIR)/e~*.o $(DIR)/$(TOP)

clean:
	del /Q $(DIR)\*.cf $(DIR)\wave.ghw $(DIR)\e~*.o $(DIR)\$(TOP) 2>nul || true