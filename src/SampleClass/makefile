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
MODULENAME = $(shell pwd | rev | awk -F \/ '{print $$1}' | rev)
LIB = lib$(MODULENAME)

INCLUDES = \
	-I.\
	-I${__ROOTDIR}\
	-I${__ROOTDIR}/src\
	-I${__ROOTDIR}/src/include\
	-I${__ROOTDIR}/src/3rdParty/Arduino\
	-I${__ROOTDIR}/src/3rdParty/Arduino/ArduinoCore\
	-I${__ROOTDIR}/src/3rdParty/Arduino/varients/standard

##Make sure to define the default and clean rules for directory
default: library
clean: clean_library

#########################################
include ${__TOOLDIR}/mk/footer.mk
