# Patent IN24/2404 202441091887 Project Medisure : Device & Method for Monitoring Blood Parameters of a User
## 🌍 Welcome to Project Medisure! 
### 💡 Prior Art
This initiative reflects our commitment to contributing meaningfully to the healthcare industry.
Over the past decade, non-invasive health monitoring has seen remarkable technological advancements, with numerous devices developed to improve patient comfort, usability, and the accuracy of health data. However, many existing solutions continue to face challenges, particularly in terms of long-term usability, patient compliance, and comprehensive health monitoring.
The proposed Medisure Care Plus device builds upon these existing systems, offering an innovative solution designed to overcome the shortcomings of current non-invasive monitoring technologies.

### 🛠️ Key Features  
- **Non-Invasive Multi-Parameter Monitoring** – Glucose, SpO₂, and pulse rate in one compact device  
- **Cost-Effective** – Minimal maintenance, no frequent strip/sensor replacements  
- **Portable & User-Friendly** – Finger-wearable design with integrated Wired Connection with mobile device for monitoring blood parameters 
- **Continuous Real-Time Data** – Accurate insights enabling early intervention  
- **Data Security** – Encrypted storage and secure communication protocols  
- **Healthcare Integration** – Seamless data sharing with healthcare providers  

### <img src="https://github.com/user-attachments/assets/6672ee8c-15ed-4fb5-9cd5-63c04ac747c1" height="24px" style="vertical-align: bottom; margin-right: 10px;"> Hardware Components
- **Arduino Nano and PCB board**: It is the foundation of the Device in which all the components are connected. Arduino IDE is the Software used to integrate the Hardware with the Software.
- **MAX30100 Sensor** :This sensor is used in order to measure the SPO2 levels and the pulse levels of the user. It combines two LED’s, a photodetector, optimized optics and low-analog signals to measure pulse and SPO2 levels. It measures by measuring the absorbance of pulsing blood through a photodetector. 
- **INA219 Current Sensor** : This is the current sensing module used in the Project and it is used in order to sense current and voltage inside the device .This module also helps in the I2C communication protocol used in the device.   
- **Glucose Strip & Sensor** : This sensor is used to measure the glucose level of the user. It consists of a strip in which the blood sample of the patient will be inserted. The strip has chemical enzymes which react with the blood which the sensor catches. Based on this reading and with the help of the current sensor, the glucose reading is found.

  
  <img width="368" height="300" alt="image" src="https://github.com/user-attachments/assets/bc606175-640b-4f84-8e35-24c12a996498" />
  
  <img width="355" height="315" alt="image" src="https://github.com/user-attachments/assets/0b3dbc86-0289-4a6a-9ccc-c016c725afcc" />

  
### 📱 Mobile Application Features  
- **User Authentication** – Secure sign-up and login functionality for personalized access  
- **Dedicated Routes for Each Parameter** – Separate interfaces for monitoring Glucose, SpO₂, and Pulse data  
- **Historical Data Tracking** – Storage and visualization of past health records for trend analysis  
- **Profile Customization** – Manage patient details with editable profiles  
- **AI-Powered Insights** – Integrated early Type 2 Diabetes detection model that continuously learns from user-specific IoT device data (Ongoing Feature)

### 📥 How to Access the Release  

You can download and test the **Medisure Health App (APK)** in two ways:  

[![Latest Release v1.0.0](https://img.shields.io/badge/release-v1.0.0-blue?style=for-the-badge)](https://github.com/rutvikbarbhai/Project-Medisure-Device-And-Method-For-Monitoring-Blood-Parameters-of-a-User./releases/download/v1.0.0/Medisure.apk)



- 👉 **Direct Download**: [Click here to download the APK](https://github.com/rutvikbarbhai/Project-Medisure-Device-And-Method-For-Monitoring-Blood-Parameters-of-a-User./releases/download/v1.0.0/Medisure.apk)
- 👉 Or go to the [Releases Page](https://github.com/rutvikbarbhai/Project-Medisure-Device-And-Method-For-Monitoring-Blood-Parameters-of-a-User./releases/tag/v1.0.0) to view all assets and details.  

<img src="https://github.com/user-attachments/assets/64abffeb-9a67-4e47-a3ec-69036aa3a343" height="30px" style="position: bottom;"> **Note**: The APK is for testing purposes only. To install on Android, enable *Install from Unknown Sources* in your device settings.  

---

## <img src="https://github.com/user-attachments/assets/6672ee8c-15ed-4fb5-9cd5-63c04ac747c1" height="24px" style="vertical-align:bottom;"> Setup Instructions  

Follow the steps below to set up and test **Project Medisure** on your system:  

### 1️⃣ Clone the Repository  
```bash
git clone https://github.com/rutvikbarbhai/Project-Medisure-Device-And-Method-For-Monitoring-Blood-Parameters-of-a-User.git
cd Project-Medisure-Device-And-Method-For-Monitoring-Blood-Parameters-of-a-User
```
### 2️⃣ Install Dependencies
```bash
flutter pub get
```
### 3️⃣ Run the App (Developer Mode)
```bash
flutter run
```
### 4️⃣ Install Pre-Built APK
```bash
wget https://github.com/rutvikbarbhai/Project-Medisure-Device-And-Method-For-Monitoring-Blood-Parameters-of-a-User/releases/latest/download/medisure.apk

adb install medisure.apk

```
<img src="https://github.com/user-attachments/assets/64abffeb-9a67-4e47-a3ec-69036aa3a343" height="30px" style="position: bottom;"> Make sure USB Debugging is enabled on your Android device if you’re installing via adb.


## 👨‍🔬 Inventors  
- **Dr. Megha P. Arakeri**  
  Professor  
  Computer Science and Engineering Department  
  Manipal Institute of Technology, Bengaluru  
  Manipal Academy of Higher Education, Manipal, India  
  Email ID: megha.arakeri@manipal.edu  
  Contact Number: +91 90089 77922  

- **Rutvik Avinash Barbhai**  
  Undergraduate Student  
  Computer Science and Engineering Department  
  Manipal Institute of Technology, Bengaluru  
  Manipal Academy of Higher Education, Manipal, India  
  Email ID: rutvik.mitblr2022@learner.manipal.edu  
  Contact Number: +91 78873 67708  

- **Sheetal Sinha**  
  Undergraduate Student  
  Computer Science and Engineering Department  
  Manipal Institute of Technology, Bengaluru  
  Manipal Academy of Higher Education, Manipal, India   
  Email ID: sheetal.mitblr2022@learner.manipal.edu  
  Contact Number: +91 99620 08641  

- **Ankit Sarkar**  
  Undergraduate Student  
  Computer Science and Engineering Department  
  Manipal Institute of Technology, Bengaluru  
  Manipal Academy of Higher Education, Manipal, India  
  Email ID: ankit3.mitblr2022@learner.manipal.edu  
  Contact Number: +91 87008 79300  



  







