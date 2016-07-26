##########################################
#          The MIT License (MIT)         #
#           Copyright (c) 2016           #
#              Jeremy Cope               #
##########################################
# The complete terms can be found in the #
# license file located in directory root.#
##########################################
# Purpose: Define generic make rules/terms
#   that are required to be defined at the
#   top of a make file.
#
##########################################
ifeq ($(HEADER),)
HEADER = true
##########################################

##PROGRAM##
PROGRAM = $(shell pwd | rev | awk -F \/ '{print $$1}' | rev)

##SOURCE/OBJ DEFINES##
CSOURCES = $(wildcard *.c)
CXXSOURCES = $(wildcard *.cpp)
SOURCES = $(CSOURCES) $(CXXSOURCES)

COBJECTS = $(addprefix $(OBJDIR)/,$(CSOURCES:.c=.$(OBJEXT)))
CXXOBJECTS = $(addprefix $(OBJDIR)/,$(CXXSOURCES:.cpp=.$(OBJEXT)))
OBJECTS = $(COBJECTS) $(CXXOBJECTS)

##COMPILE SETTINGS##

#Default
CC = gcc
CCFLAGS = -g -Wall -DTARGET=${__TARGET}
CXX = c++
CXXFLAGS = -g -Wall -DTARGET=${__TARGET}

#If Arduino Target
ifeq (${__TARGET},ARDUINO)
CC = avr-gcc
CCFLAGS = -g -Os -Wall -ffunction-sections -fdata-sections -mmcu=atmega328p -DF_CPU=16000000L -MMD -DUSB_VID=null -DUSB_PID=null -DARDUINO=103 -DTARGET=${__TARGET}
CXX = avr-g++
CXXFLAGS = -g -Os -Wall -fno-exceptions -ffunction-sections -fdata-sections -mmcu=atmega328p -DF_CPU=16000000L -MMD -DUSB_VID=null -DUSB_PID=null -DARDUINO=103 -DTARGET=${__TARGET}
endif


##LINK SETTINGS##
#Default
CXXLD = c++
LDFLAGS = -g -lpthread

#If Arduino Target
ifeq (${__TARGET},ARDUINO)
CXXLD = avr-ar
LDFLAGS = rcs
endif

##OBJECT SETTINGS##
OBJEXT = o
OBJDIR = obj

##LIBRARY SETTINGS##
LIBDIR = lib

#Default, OSX
LIBFLAGS = -dynamiclib -undefined dynamic_lookup
LIBEXT = .dylib
LIBRARY = $(LIB)$(LIBEXT)
LIB_BUILD = $(CXXLINK) $(LIBFLAGS) $(OBJECTS) -o $(LIBDIR)/$@

#If Arduino Target
ifeq (${__TARGET},ARDUINO)
LIBFLAGS =
LIBEXT = .a
LIBRARY = $(LIB)$(LIBEXT)
LIB_BUILD = $(CXXLINK) $(LIBDIR)/$(LIBRARY) $(OBJECTS)
endif


##UNITTEST SETTINGS##
UT = $(UnitTest)$(UTEXT)
UTEXT = 

##PROGRAM SETTINGS##
BINDIR = bin
BINARY = $(PROGRAM)$(BINARYEXT)
BINARYFLAGS = $(PROGRAM_LIB_INCLUDES) $(PROGRAM_LIBRARIES)

#Default
BINARYEXT = 
BIN_BUILD = $(CXX) -lpthread -o $(BINDIR)/$(BINARY) $(OBJDIR)/$(SOURCE:.cpp=.$(OBJEXT)) $(BINARYFLAGS)

#If Arduino Target
ifeq (${__TARGET},ARDUINO)
BINARYEXT = .elf
BIN_BUILD = \
	$(CXX) -Wl,-Map,$(BINDIR)/$(PROGRAM).map,--cref -mmcu=atmega328p -o "$(BINDIR)/$(BINARY)" $(OBJDIR)/$(SOURCE:.cpp=.$(OBJEXT)) $(BINARYFLAGS);\
	$(OBJDUMP) $(OBJDUMPFLAGS) $(BINDIR)/$(BINARY) >"$(BINDIR)/$(PROGRAM).lss";\
	$(OBJCOPY) -R .eeprom -O ihex $(BINDIR)/$(BINARY) "$(BINDIR)/$(PROGRAM).hex";\
	$(OBJCOPY) -j .eeprom --set-section-flags=.eeprom=alloc,load --no-change-warnings --change-section-lma .eeprom=0 -O ihex $(BINDIR)/$(BINARY) "$(BINDIR)/$(PROGRAM).eep";\
	$(OBJSIZE) $(OBJSIZEFLAGS) $(BINDIR)/$(BINARY);
endif

##AVR SETTINGS##
OBJDUMP = avr-objdump
OBJDUMPFLAGS = -h -S
OBJCOPY = avr-objcopy
OBJSIZE = avr-size
OBJSIZEFLAGS = --format=avr --mcu=atmega328p

##BUILD COMMANDS##
CCCOMPILE = $(CC) $(INCLUDES) $(CCFLAGS)
CXXCOMPILE = $(CXX) $(INCLUDES) $(CXXFLAGS)
CXXLINK = $(CXXLD) $(LDFLAGS) 

##########################################
endif
