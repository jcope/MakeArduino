/*****************************************
          The MIT License (MIT)
           Copyright (c) 2016
              Jeremy Cope
 *****************************************
 The complete terms can be found in the
 license file located in directory root.
 *****************************************
 Purpose: To demonstrate sample unit test
       and test out the build environment. 
 ****************************************/
#include <gtest/gtest.h>
#include "../SampleClass.h"

using namespace std;

class SampleClassTest : public ::testing::Test {
 protected:
	// Called before the first test in this test case.
  	static void SetUpTestCase() {
		utClass = new SampleClass();
  	}

  	// Called after the last test in this test case.
  	static void TearDownTestCase() {
    	delete utClass;
    	utClass = NULL;
  	}

  	// Called prior to each individual test
  	virtual void SetUp() {
		//Make sure the instance variable isn't null
		EXPECT_NE(utClass,(void*)NULL);
  	}
  
	// Called after each individual test
	virtual void TearDown() { 
	}

  	// Some expensive resource shared by all tests.
  	static SampleClass* utClass;
};

SampleClass* SampleClassTest::utClass = NULL;

/***************BEGIN TESTS***************/
TEST_F(SampleClassTest, randomNumber) {
	int retRandom = 0;
	retRandom = SampleClass::randomNumber(125);
	EXPECT_EQ(retRandom,retRandom); //Inapropriate test to make sure function doesn't crash
}