##########################################
#          The MIT License (MIT)         #
#           Copyright (c) 2016           #
#              Jeremy Cope               #
##########################################
# The complete terms can be found in the #
# license file located in directory root.#
##########################################
include ${__TOOLDIR}/mk/header.mk
##########################################

SOURCE = main.cpp

INCLUDES = \
	-I.\
	-I./src/include\
	-I./src\
	-I./src/3rdParty/Arduino\
	-I./src/3rdParty/Arduino/ArduinoCore\
	-I./src/3rdParty/Arduino/varients/standard

PROGRAM_DEPENDENCIES = \
	$(OBJDIR)/$(SOURCE:.cpp=.$(OBJEXT))

PROGRAM_MODULES = \
	${__ROOTDIR}/src/SampleClass


PROGRAM_LIBRARIES = \
	-lSampleClass

ifeq (${__TARGET},ARDUINO)

PROGRAM_MODULES :=\
	${__ROOTDIR}/src/3rdParty/Arduino/ArduinoCore\
	${__ROOTDIR}/src/3rdParty/Arduino/SPI\
	${__ROOTDIR}/src/SampleClass

PROGRAM_LIBRARIES := \
	-lSampleClass\
	-lSPI\
	-lArduinoCore
endif

PROGRAM_LIB_INCLUDES = \
	-L./lib

##Make sure to define the default and clean rules for directory
default: program
clean: clean_all

##########################################
include ${__TOOLDIR}/mk/footer.mk


