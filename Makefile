#
#  Makefile for adHocSim
#
#  ** This file was automatically generated by the command:
#  opp_makemake -o adHocSim -f -u cmdEnv
#

# Name of target to be created (-o option)
TARGET = adHocSim

# User interface (uncomment one) (-u option)
USERIF_LIBS=$(CMDENV_LIBS)
# USERIF_LIBS=$(TKENV_LIBS)

# .ned or .h include paths with -I
INCLUDE_PATH=

# misc additional object and library files to link
EXTRA_OBJS=

# object files from other directories to link with (wildcard needed to prevent "no such file *.o" errors)
EXT_DIR_OBJS=

# time stamps of other directories (used as dependency)
EXT_DIR_TSTAMPS=

# Additional libraries (-L option -l option)
LIBS=

#------------------------------------------------------------------------------

# Generic definitions. To avoid redundancies across Makefiles, you can
# import them from a common file -- see opp_makemake -c flag.
NEDC=/home/concer/omnetpp/bin/nedtool
MSGC=opp_msgc
CXX=g++
CC=gcc
AR=ar cr
SHLIB_LD=g++ -shared 
MAKEDEPEND=opp_makedep -Y --objdirtree

CFLAGS=-O2 -DNDEBUG=1   -DWITH_PARSIM -DWITH_NETBUILDER
NEDCFLAGS=-Wno-unused
LDFLAGS= -Wl,--export-dynamic
EXE_SUFFIX=

WITH_PARSIM=yes
WITH_NETBUILDER=yes

OMNETPP_INCL_DIR=/home/concer/omnetpp/include
OMNETPP_LIB_DIR=/home/concer/omnetpp/lib

TK_LIBS=-L/usr/lib -ltk8.4 -ltcl8.4
MPI_LIBS=
XML_LIBS=-lxml2
SYS_LIBS=-ldl -lstdc++ 
SYS_LIBS_PURE=-ldl -lsocket -lnsl -lm $(shell $(CXX) -print-file-name=libstdc++.a)

# User interface libs
CMDENV_LIBS=-lenvir -lcmdenv
TKENV_LIBS=-lenvir -ltkenv $(TK_LIBS)

# Simulation kernel
KERNEL_LIBS=-lsim_std

ifeq ($(WITH_NETBUILDER),yes)
KERNEL_LIBS += -lnedxml $(XML_LIBS)
endif

ifeq ($(WITH_PARSIM),yes)
KERNEL_LIBS += $(MPI_LIBS)
endif

# Simulation kernel and user interface libraries
OMNETPP_LIBS=-L$(OMNETPP_LIB_DIR) $(USERIF_LIBS) $(KERNEL_LIBS) $(SYS_LIBS)

COPTS=$(CFLAGS) $(INCLUDE_PATH) -I$(OMNETPP_INCL_DIR)
NEDCOPTS=$(COPTS) $(NEDCFLAGS)
MSGCOPTS= $(INCLUDE_PATH)

#------------------------------------------------------------------------------

# subdirectories to recurse into
SUBDIRS= 

# object files in this directory
OBJS= mobileHost_n.o simple_n.o world_n.o  aodv.o application.o mac.o  normal.o physic.o pursuit.o randomDirection.o randomWalk.o randomWP.o restrictedRandWalk.o  

# header files generated (from msg files)
GENERATEDHEADERS= 

#------------------------------------------------------------------------------

$(TARGET): $(OBJS) $(EXTRA_OBJS) $(EXT_DIR_TSTAMPS) Makefile
	$(CXX) $(LDFLAGS) $(OBJS) $(EXTRA_OBJS) $(EXT_DIR_OBJS) $(LIBS) $(OMNETPP_LIBS) -o $(TARGET)
	echo>.tstamp

$(OBJS) : $(GENERATEDHEADERS)


purify: $(OBJS) $(EXTRA_OBJS) $(EXT_DIR_TSTAMPS) Makefile
	purify $(CXX) $(LDFLAGS) $(OBJS) $(EXTRA_OBJS) $(EXT_DIR_OBJS) $(LIBS) -L$(OMNETPP_LIB_DIR) $(KERNEL_LIBS) $(USERIF_LIBS) $(SYS_LIBS_PURE) -o $(TARGET).pure

.PHONY: subdirs $(SUBDIRS)

subdirs: $(SUBDIRS)

mobileHost_n.o: mobileHost_n.cc
	$(CXX) -c $(NEDCOPTS) mobileHost_n.cc

mobileHost_n.cc: mobileHost.ned
	$(NEDC) $(INCLUDE_PATH) mobileHost.ned

simple_n.o: simple_n.cc
	$(CXX) -c $(NEDCOPTS) simple_n.cc

simple_n.cc: simple.ned
	$(NEDC) $(INCLUDE_PATH) simple.ned

world_n.o: world_n.cc
	$(CXX) -c $(NEDCOPTS) world_n.cc

world_n.cc: world.ned
	$(NEDC) $(INCLUDE_PATH) world.ned

aodv.o: aodv.cc
	$(CXX) -c $(COPTS) aodv.cc

application.o: application.cc
	$(CXX) -c $(COPTS) application.cc

mac.o: mac.cc
	$(CXX) -c $(COPTS) mac.cc

normal.o: normal.cc
	$(CXX) -c $(COPTS) normal.cc

physic.o: physic.cc
	$(CXX) -c $(COPTS) physic.cc

pursuit.o: pursuit.cc
	$(CXX) -c $(COPTS) pursuit.cc

randomDirection.o: randomDirection.cc
	$(CXX) -c $(COPTS) randomDirection.cc

randomWalk.o: randomWalk.cc
	$(CXX) -c $(COPTS) randomWalk.cc

randomWP.o: randomWP.cc
	$(CXX) -c $(COPTS) randomWP.cc

restrictedRandWalk.o: restrictedRandWalk.cc
	$(CXX) -c $(COPTS) restrictedRandWalk.cc


#doc: neddoc doxy

#neddoc:
#	opp_neddoc -a

#doxy: doxy.cfg
#	doxygen doxy.cfg

generateheaders: $(GENERATEDHEADERS)
	for i in $(SUBDIRS); do (cd $$i && $(MAKE) generateheaders) || exit 1; done

clean:
	rm -f $(TARGET)$(EXE_SUFFIX)
	rm -f *.o *_n.cc *_n.h *_m.cc *_m.h .tstamp
	rm -f *.vec *.sca
	for i in $(SUBDIRS); do (cd $$i && $(MAKE) clean); done

depend:
	$(MAKEDEPEND) $(INCLUDE_PATH) -- *.cc
	# $(MAKEDEPEND) $(INCLUDE_PATH) -fMakefile.in -- *.cc
	for i in $(SUBDIRS); do (cd $$i && $(MAKE) depend) || exit 1; done

makefiles:
	# recreate Makefile
	opp_makemake -f  -o adHocSim -u cmdEnv 
	for i in $(SUBDIRS); do (cd $$i && $(MAKE) makefiles) || exit 1; done

makefile-ins:
	# recreate Makefile.in
	opp_makemake -f -m  -o adHocSim -u cmdEnv 
	for i in $(SUBDIRS); do (cd $$i && $(MAKE) makefile-ins) || exit 1; done

# "re-makemake" and "re-makemake-m" are deprecated, historic names of the above two targets
re-makemake: makefiles
re-makemake-m: makefile-ins


# DO NOT DELETE THIS LINE -- make depend depends on it.
aodv.o: aodv.cc \
  h/aodv.h \
  h/aodvCostants.h \
  h/costants.h
application.o: application.cc \
  h/application.h \
  h/costants.h \
  h/physic.h
mac.o: mac.cc \
  h/mac.h \
  h/costants.h
mobileHost_n.o: mobileHost_n.cc
normal.o: normal.cc \
  h/normal.h \
  h/costants.h \
  h/physic.h
physic.o: physic.cc \
  h/physic.h \
  h/costants.h
pursuit.o: pursuit.cc \
  h/pursuit.h \
  h/costants.h \
  h/physic.h
randomDirection.o: randomDirection.cc \
  h/randomDirection.h \
  h/costants.h \
  h/physic.h
randomWalk.o: randomWalk.cc \
  h/randomWalk.h \
  h/costants.h \
  h/physic.h
randomWP.o: randomWP.cc \
  h/randomWP.h \
  h/costants.h \
  h/physic.h
restrictedRandWalk.o: restrictedRandWalk.cc \
  h/restrictedRandWalk.h \
  h/costants.h \
  h/physic.h
simple_n.o: simple_n.cc
world_n.o: world_n.cc
