/*
Arduino-MAX30100 oximetry / heart rate integrated sensor library
Copyright (C) 2016  OXullo Intersecans <x@brainrapers.org>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <Wire.h>
#include "MAX30100_PulseOximeter.h"
#include <Adafruit_INA219.h>


Adafruit_INA219 ina219(0x45);


#define REPORTING_PERIOD_MS     3000

// PulseOximeter is the higher level interface to the sensor
// it offers:
//  * beat detection reporting
//  * heart rate calculation
//  * SpO2 (oxidation level) calculation
PulseOximeter pox;

uint32_t tsLastReport = 0;

// Callback (registered below) fired when a pulse is detected
void onBeatDetected()
{
    Serial.println("Beat!");
}

void setup()
{
    Serial.begin(9600);
    //delay(10);
    Serial.println("Starting ...");

    if (! ina219.begin())  {
      // Initialize the INA219.
    // By default the initialization will use the largest range (32V, 2A).  However
    // you can call a setCalibration function to change this range (see comments).
  
    Serial.println("Failed to find INA219 chip");
      while (1) { delay(10); }
    }
    // To use a slightly lower 32V, 1A range (higher precision on amps):
    //ina219.setCalibration_32V_1A();
    // Or to use a lower 16V, 400mA range (higher precision on volts and amps):
    ina219.setCalibration_16V_400mA();

    // Initialize the PulseOximeter instance
    // Failures are generally due to an improper I2C wiring, missing power supply
    // or wrong target chip
    if (!pox.begin()) {
        Serial.println("FAILED to Find MAX30100");
    //    for(;;);
     //  while (1) { delay(10); }
    } 
    delay(10);
    
    // The default current for the IR LED is 50mA and it could be changed
    //   by uncommenting the following line. Check MAX30100_Registers.h for all the
    //   available options.
     pox.setIRLedCurrent(MAX30100_LED_CURR_7_6MA);

    // Register a callback for the beat detection
    //pox.setOnBeatDetectedCallback(onBeatDetected);
   
    

}

void loop()
{
    // Make sure to call update as fast as possible
    pox.update();
    float shuntvoltage = 0;
    float busvoltage = 0;
    float current_mA = 0;
    float loadvoltage = 0;
    float power_mW = 0;
    float resistence = 0;
    // Asynchronously dump heart rate and oxidation levels to the serial
    // For both, a value of 0 means "invalid"
    if (millis() - tsLastReport > REPORTING_PERIOD_MS) {
    //    Serial.print("Heart rate:");
    //    Serial.print(pox.getHeartRate());
    //    Serial.print("bpm / SpO2:");
    //    Serial.print(pox.getSpO2());
    //    Serial.print("% / ");

        shuntvoltage = ina219.getShuntVoltage_mV();
        busvoltage = ina219.getBusVoltage_V();
        current_mA = ina219.getCurrent_mA();
        power_mW = ina219.getPower_mW();
        loadvoltage = busvoltage + (shuntvoltage / 1000);
        if(current_mA > 0.0)
        { resistence = loadvoltage*1000/current_mA; }
        Serial.print("Bus Voltage:   "); Serial.print(busvoltage); Serial.print(" V");
        Serial.print("  Shunt Voltage: "); Serial.print(shuntvoltage); Serial.print(" mV");
        Serial.print("  Resistence:"); Serial.print(resistence); Serial.print("Ohms");
        Serial.print("  Current:"); Serial.print(current_mA); Serial.println("mAmp");
      //  Serial.print("Power:         "); Serial.print(power_mW); Serial.println(" mWatt");
      //  Serial.println("");

        tsLastReport = millis();
     }
}
