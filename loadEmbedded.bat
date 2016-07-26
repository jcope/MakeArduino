::##########################################
::#          The MIT License (MIT)         #
::#           Copyright (c) 2016           #
::#              Jeremy Cope               #
::##########################################
::# The complete terms can be found in the #
::# license file located in directory root.#
::##########################################
@echo off

::Program Settings
set HEXFILE="bin\MakeArduino.hex"
set AVRDIR="tools\avr"

::Set Tool Locations
set AVRDUDE="C:\Program Files\WinAvr\bin\avrdude"
::set AVRDUDEFLAGS=-pm328p -carduino -PCOM3 -b115200 -Uflash:w:%HEXFILE%:a
set AVRDUDEFLAGS=-C%AVRDIR%\avrdude.conf -patmega328p -carduino -P\\.\COM6 -b115200 -D -Uflash:w:%HEXFILE%:a

::Execute Commands
echo %AVRDUDE% %AVRDUDEFLAGS%
%AVRDUDE% %AVRDUDEFLAGS%
echo "Done"
