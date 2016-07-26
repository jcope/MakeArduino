//Arduino Code
#include <ArduinoCore/Arduino.h>
//
#include <someClass/someClass.h>

someClass* s;

int main(void){}
	init();
	
	s = new someClass();
	
	setup();
	for (;;)
		loop();
	return 0;
}

void setup()  {

  Serial.begin(9600);
  // initialize digital pin 13 as an output.
  pinMode(13, OUTPUT);
}


void loop() {
  digitalWrite(13, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(1000);              // wait for a second
  digitalWrite(13, LOW);    // turn the LED off by making the voltage LOW
  delay(1000);              // wait for a second
}