/*
DTU/Heriot-Watt Clinic 2023-24
Data Acquisition Sketch

This sketch runs on the VAWT's Teensy to collect data from all of the sensors. 
*/

#include <Arduino.h>
#include <Wire.h>
#include <avr/io.h>
#include <avr/interrupt.h>

#include <Pinouts.h>
#include <TimingOffsets.h>
#include <ADCSampler.h>
#include <ErrorFlagSampler.h>
#include <ButtonSampler.h> // A template of a data source library
#include <Logger.h>
#include <Printer.h>

/////////////////////////* Global Variables *////////////////////////

ADCSampler adc;
ButtonSampler button_sampler;
Logger logger;
Printer printer;

// loop start recorder
int loopStartTime;
int currentTime;

////////////////////////* Setup *////////////////////////////////

void setup() {
  
  logger.include(&adc);
  logger.include(&button_sampler);
  logger.init();

  printer.init();
  adc.init();
  button_sampler.init();

  printer.printMessage("Starting main loop",10);
  loopStartTime = millis();
  printer.lastExecutionTime            = loopStartTime - LOOP_PERIOD + PRINTER_LOOP_OFFSET ;
  adc.lastExecutionTime                = loopStartTime - LOOP_PERIOD + ADC_LOOP_OFFSET;
  button_sampler.lastExecutionTime     = loopStartTime - LOOP_PERIOD + BUTTON_LOOP_OFFSET;
  logger.lastExecutionTime             = loopStartTime - LOOP_PERIOD + LOGGER_LOOP_OFFSET;

}



//////////////////////////////* Loop */////////////////////////

void loop() {
  currentTime=millis();
    
  if ( currentTime-printer.lastExecutionTime > LOOP_PERIOD ) {
    printer.lastExecutionTime = currentTime;
    printer.printValue(0,adc.printSample());
    printer.printValue(1,logger.printState());        
    printer.printToSerial();  // To stop printing, just comment this line out
  }
  
  if ( currentTime-adc.lastExecutionTime > LOOP_PERIOD ) {
    adc.lastExecutionTime = currentTime;
    adc.updateSample(); 
  }

  if ( currentTime-button_sampler.lastExecutionTime > LOOP_PERIOD ) {
    button_sampler.lastExecutionTime = currentTime;
    button_sampler.updateState();
  }

  if ( currentTime- logger.lastExecutionTime > LOOP_PERIOD && logger.keepLogging ) {
    logger.lastExecutionTime = currentTime;
    logger.log();
  }
}

