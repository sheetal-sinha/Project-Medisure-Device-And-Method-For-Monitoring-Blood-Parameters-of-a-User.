#include <Wire.h>
#include "MAX30100_PulseOximeter.h"  // Alternative library for MAX30100
#include "Adafruit_INA219.h"         // Library for INA219 (Voltage & Current)

PulseOximeter pox;  // Create an instance of MAX30100
Adafruit_INA219 ina219; // Create an instance of INA219

float glucoseLevel;  // Variable for glucose estimation
unsigned long lastUpdate = 0;

void onBeatDetected() {
    Serial.println("♥ Beat detected!");
}

void setup() {
    Serial.begin(115200);
    Wire.begin();

    if (!pox.begin()) {
        Serial.println("ERROR: MAX30100 Failed to initialize!");
        while (1);
    }
    Serial.println("MAX30100 Initialized!");
    pox.setOnBeatDetectedCallback(onBeatDetected);
    pox.setIRLedCurrent(MAX30100_LED_CURR_7_6MA);

    if (!ina219.begin()) {
        Serial.println("ERROR: INA219 Not Found!");
        while (1);
    }
    Serial.println("INA219 Initialized!");
}

void loop() {
    pox.update();
    float heartRate = pox.getHeartRate();
    float SpO2 = pox.getSpO2();

    float busVoltage = ina219.getBusVoltage_V();
    float current_mA = ina219.getCurrent_mA();

    glucoseLevel = (current_mA * 50) + (busVoltage * 10);

    if (millis() - lastUpdate > 1000) {
        Serial.print("Glucose Level: ");
        Serial.print(glucoseLevel);
        Serial.println(" mg/dL");

        Serial.print("Oxygen Level: ");
        Serial.print(SpO2);
        Serial.println("%");

        Serial.print("Heart Rate: ");
        Serial.print(heartRate);
        Serial.println(" BPM");

        Serial.println("------------------------------------");
        lastUpdate = millis();
    }
}
