#! /bin/bash
##########################################
#          The MIT License (MIT)         #
#           Copyright (c) 2016           #
#              Jeremy Cope               #
##########################################
# The complete terms can be found in the #
# license file located in directory root.#
##########################################
#Determine the OS

export __AVRTOOLCHAINDIR=/usr/local/CrossPack-AVR

#System Path Variables
export __ROOTDIR=`pwd`
export __TOOLDIR=${__ROOTDIR}/tools
export __SRCDIR=${__ROOTDIR}/src

#Build, Runtime Variables
export DYLD_LIBRARY_PATH=${DYLD_LIBRARY_PATH}:${__ROOTDIR}/lib
