/*
DataAcq.ino
Modified: January 2025
Author: Victoria Parizot
Email: vparizot@g.hmc.edu

Denmark Technical University/Heriot-Watt 2024-2025 Clinic Team Data Acquisition Sketch

Purpose: Data Acquisition for the current, windvane, and anemometer sensors of the power 
         electronics of the VAWT. Runs on a Teensy 4.2 and reads the voltage output from 
         the sensors and logs sensor data in desired units.  

Used HMC E80 Source Code for SD card support: https://github.com/HMC-E80/E80/blob/main/E80_Lab_01/E80_Lab_01.ino
*/

////////////////////////////////////////////////////////
//* E80 SD card printing includes & global variables *//
////////////////////////////////////////////////////////

#include <Arduino.h>
#include <Wire.h>
// #include "libraries/main/Pinouts.h"
// #include <Pinouts.h>

// #include <SensorIMU.h>
// #include <MotorDriver.h>
// #include "libraries/main/Logger.h"
// #include "libraries/main/Printer.h"

/* Global Variables */
// period in ms of logger and printer
// #define LOOP_PERIOD 100

// Logger
// Logger logger;
// bool keepLogging = true;

// Printer
// Printer printer;

// loop start recorder
// int loopStartTime;

////////////////////////////////////////////////////////
//* Constants, Pins & Defines for DTU/HWU Clinic Team */
////////////////////////////////////////////////////////

// Define Pinouts
const int currentPin = A5; // Analog input pin, pin 19
const int windVanePin = A2; // Analog input pin, pin 16
const int anemomPin = A0; // Analog input pin, pin 14

// Constants for analog inputs, [0 - 1023]
int currentVal;
int windVaneVal;
int anemonVal;

// Constants for voltages
float currentVolt;
float windVaneVolt;
float anemonVolt;

// Constants for quantities
float currentAmps;
float windVaneDeg;
float anemonSpeed;

// Constants for conversion
float currentConversionConstant = 0.185; // 0.185V per amp
float windVaneSlope = 0.00863; // TODO
float windVaneOffset = 0.795; // TODO
float anemConvConstant = 5.85; // speed [m/s] = Voltage/5 * A + B = V/5 * 45 + 0 = V * 9
float anemOffset = 0; //0.334;


void setup() {
  /* Initialize Logger & Printer (from E80 Code) */
  // printer.init();
  // logger.include(&imu);
  // logger.include(&motorDriver);
  // logger.init();
  // printer.printMessage("Starting main loop",10);
  // loopStartTime = millis();

  /* Initialize serial monitor in Arduino IDE*/
  Serial.begin(9600);

}

void loop() {
  /* Define current Time */
  // int currentTime = millis() - loopStartTime;

  /* SENSOR CODE & CONVERSIONS */
  // Read and store Current pin
  currentVal = analogRead(currentPin); // returns value between 0 to 1023
  currentVolt = currentVal * (3.3/1023.0); // convert analog value to voltage
  currentAmps = (currentVolt-2.6)/currentConversionConstant; // Offset by 2.63 (voltage at zero) to get current in Amps
  Serial.print("Current[volts, amps]: ");
  Serial.print(currentVolt); 
  Serial.print(",");
  Serial.println(currentAmps);
  // Serial.print("Current [amps] is: ");
  // Serial.println(currentAmps);
  // Serial.println();

  // Read and store windvane pin
  windVaneVal = analogRead(windVanePin); // returns value between 0 to 1023
  windVaneVolt = windVaneVal * (3.3/1023.0); // convert analog value to voltage
  windVaneDeg = int((159*windVaneVolt + 244)) % 360; // get current in Amps

  Serial.print("WindVane[volt, degrees]: "); 
  Serial.print(windVaneVolt);
  Serial.print(",");

  // Serial.print("WindVane [degrees] is: ");
  Serial.println(windVaneDeg);


  // Read and store anemometer pin
  anemonVal = analogRead(anemomPin); // returns value between 0 to 1023
  anemonVolt = anemonVal * (3.3/1023.0); // convert analog value to voltage
  anemonSpeed = anemConvConstant*anemonVolt - anemOffset; // get current in Amps
  Serial.print("Anemometer[voltage, speed]: ");
  Serial.print(anemonVolt);
  Serial.print(",");

  // Serial.print("Anemometer [m/s] is: ");
  Serial.println(anemonSpeed);

  /* Code to keep the logger logging */
  // if ( currentTime-printer.lastExecutionTime > LOOP_PERIOD ) {
  //   printer.lastExecutionTime = currentTime;
  //   printer.printValue(0,imu.printAccels());
  //   printer.printValue(1,imu.printRollPitchHeading());
  //   printer.printValue(2,motorDriver.printState());
  //   printer.printToSerial();  // To stop printing, just comment this line out
  // }

  // if ( currentTime-imu.lastExecutionTime > LOOP_PERIOD ) {
  //   imu.lastExecutionTime = currentTime;
  //   imu.read(); // this is a sequence of blocking I2C read calls
  // }

  // if ( currentTime-logger.lastExecutionTime > LOOP_PERIOD && logger.keepLogging) {
  //   logger.lastExecutionTime = currentTime;
  //   logger.log();
  // }

  delay(100); // wait .1 sec (100 ms sample time)
  
}

