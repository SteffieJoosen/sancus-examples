SUBDIRS1       = $(shell find * -maxdepth 0 -type d)
SUBDIRS2        = $(filter-out sancus-step, $(SUBDIRS1))
SUBDIRS         = $(filter-out timer, $(SUBDIRS2))
SUBDIR_ALL      = $(SUBDIRS:=.all)
SUBDIR_SIM      = $(SUBDIRS:=.sim)
SUBDIR_CLEAN    = $(SUBDIRS:=.clean)

all: $(SUBDIR_ALL)
sim: $(SUBDIR_SIM)
clean: $(SUBDIR_CLEAN)

$(SUBDIR_ALL): %.all:
	make -C $* all

$(SUBDIR_SIM): %.sim:
	unbuffer make -C $* clean sim | tee sim.out && ! grep -iqE "fail|error:" sim.out

$(SUBDIR_CLEAN): %.clean:
	make -C $* clean
