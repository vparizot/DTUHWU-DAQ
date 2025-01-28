/*
DTU/Heriot-Watt Clinic 2024-25
Data Acquisition Sketch

This sketch runs on the VAWT's Teensy to collect data from all of the sensors. 
*/

// Define Pinouts
#define currentPin A5; // Analog input pin
#define windVanePin A2; // Analog input pin
#define anemomPin 0; // Analog input pin

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
  currentVolt = currentVal * (5.0/1023.0); // convert analog value to voltage
  currentAmps = currentVolt/currentConversionConstant; // get current in Amps
  Serial.print("Current [amps] is: ");
  Serial.println(currentAmps);

  // Read and store windvane pin
  windVaneVal = analogRead(windVanePin); // returns value between 0 to 1023
  windVaneVolt = windVaneVal * (5.0/1023.0); // convert analog value to voltage
  windVaneDir = windVaneVolt/windVaneConversionConstant; // get current in Amps
  Serial.print("WindVane [Voltage] is: ");
  Serial.println(windVaneDir);

  // Read and store anemometer pin
  anemonVal = analogRead(anemomPin); // returns value between 0 to 1023
  anemonVolt = anemonVal * (5.0/1023.0); // convert analog value to voltage
  anemonSpeed = anemonVolt*anemConvConstant; // get current in Amps
  Serial.print("Anemometer [m/s] is: ");
  Serial.println(anemonSpeed);

  delay(1000); // wait 1 sec (1000 ms sample time)
}

