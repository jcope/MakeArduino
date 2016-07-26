/*****************************************
          The MIT License (MIT)
           Copyright (c) 2016
              Jeremy Cope
 *****************************************
 The complete terms can be found in the
 license file located in directory root.
 *****************************************
 Purpose: This class provides and example
			of simple functionality
 ****************************************/
#ifndef SAMPLECLASS_H
#define SAMPLECLASS_H

#include <stdint.h> //uint8_t

class SampleClass {
  public:
    SampleClass();
    ~SampleClass();
	static int randomNumber(int max);
	static int randomNumber(int min, int max);
	
	static void extractRGBvalues(uint8_t baseValue, uint8_t& r, uint8_t& g, uint8_t& b);
	
	static void initClass();
	static bool init;
	
};


#endif
