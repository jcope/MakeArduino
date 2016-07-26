/*****************************************
          The MIT License (MIT)
           Copyright (c) 2016
              Jeremy Cope
 *****************************************
 The complete terms can be found in the
 license file located in directory root.
 *****************************************
 Purpose:

 ****************************************/
#include "SampleClass.h"

#if TARGET == OSX
//OSX
#include <stdlib.h> //rand
#include <ctime> //time
#include <sys/time.h> //ms time

#elif TARGET == ARDUINO
//Arduino
#include <Arduino.h>
#endif

//Dual Target
#include <stdint.h> //uint8_t

bool SampleClass::init = false;

SampleClass::SampleClass(){
	initClass();
}

SampleClass::~SampleClass(){
	
}
void SampleClass::initClass(){
	//Seed the random num generator
	#if TARGET == OSX
		//OSX
		srand(time(0));
	#elif TARGET == ARDUINO
		//Arduino
		randomSeed(analogRead(0));
	#endif
	
	init = true;
}

int SampleClass::randomNumber(int max){
	
	return randomNumber(0,max);
}

//TODO: Verify the minimum
int SampleClass::randomNumber(int min, int max){
	if(!init) initClass();

	uint8_t randomValue;
	
	//How we get a random number depends on the target
	#if TARGET == OSX
		//OSX
		randomValue = rand() % max;
	#elif TARGET == ARDUINO
		//Arduino
		randomValue = random(max);
	#endif
	
	return randomValue;
}