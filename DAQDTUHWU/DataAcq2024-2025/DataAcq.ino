/*
DataAcq.ino
Modified: January 2025
Author: Victoria Parizot
Email: vparizot@g.hmc.edu

Denmark Technical University/Heriot-Watt 2024-2025 Clinic Team Data Acquisition Sketch

Purpose: Data Acquisition for the current, windvane, and anemometer sensors of the power 
         electronics of the VAWT. Runs on a Teensy 4.2 and reads the voltage output from 
         the sensors and logs sensor data in desired units.  
*/

// Define Pinouts
const int currentPin = A5; // Analog input pin
const int windVanePin = A2; // Analog input pin
const int anemomPin = A0; // Analog input pin

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
float windVaneDir;
float anemonSpeed;

// Constants for conversion
float currentConversionConstant = 0.185; // 0.185V per amp
float windVaneConversionConstant = 1; // TODO
float anemConvConstant = 9; // speed [m/s] = Voltage/5 * A + B = V/5 * 45 + 0 = V * 9


void setup() {
 Serial.begin(9600);
}

void loop() {
  // Read and store Current pin
  currentVal = analogRead(currentPin); // returns value between 0 to 1023
  currentVolt = currentVal * (3.3/1023.0); // convert analog value to voltage
  currentAmps = (currentVolt-2.63)/currentConversionConstant; // Offset by 2.63 (voltage at zero) to get current in Amps
  
  // Serial.print("Curr voltage is: ");
  // Serial.println(currentVolt);
  Serial.print("Current [amps] is: ");
  Serial.println(currentAmps);

  // Read and store windvane pin
  /*
  windVaneVal = analogRead(windVanePin); // returns value between 0 to 1023
  windVaneVolt = windVaneVal * (3.3/1023.0); // convert analog value to voltage
  windVaneDir = windVaneVolt/windVaneConversionConstant; // get current in Amps
  Serial.print("WindVane [Voltage] is: ");
  Serial.println(windVaneDir);
  */

  // Read and store anemometer pin
  anemonVal = analogRead(anemomPin); // returns value between 0 to 1023
  anemonVolt = anemonVal * (3.3/1023.0); // convert analog value to voltage
  anemonSpeed = anemonVolt*anemConvConstant; // get current in Amps
  Serial.print("Anemometer [m/s] is: ");
  Serial.println(anemonSpeed);
  delay(1000); // wait 1 sec (1000 ms sample time)
  
}

