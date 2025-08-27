# <img src="https://github.com/user-attachments/assets/f3dcee8e-e008-457a-97fb-d3848b425713" height="30px" style="vertical-align:text-bottom;"> Repository Structure - medisure/lib/screens/
The `screens/` directory contains all **UI screens (pages)** of the Medisure application.  
Each screen represents a distinct feature or flow for the user, handling interaction, navigation, and data visualization.  

## 📄 Files Overview
`medisure/lib/screens/Spo2_screen.dart` : Displays the **SpO2 (Oxygen Saturation) levels** of the user.Pulls real-time data from the Medisure device or Firestore.

`medisure/lib/screens/forgot_password_screen.dart`: Screen for **password recovery**. Allows users to reset their credentials via email or OTP flow.  

`medisure/lib/screens/glucose_screen.dart` : Shows **blood glucose levels**. Useful for diabetic users to monitor real-time glucose readings.

`medisure/lib/screens/levels.dart` : Displays **user levels, progress, or achievements**. Could also include health insights based on cumulative readings. 

`medisure/lib/screens/login_screen.dart` :Handles **user authentication**. Provides login functionality with email/password or cloud integration.  

`medisure/lib/screens/past_records_screen.dart`: Allows users to **view historical health records**. Displays trends, previous test results, and medical history.

`medisure/lib/screens/profile_edit_screen.dart`: Enables users to **edit and update their profile information**. Example: name, age, contact info, medical details. 

`medisure/lib/screens/signup_screen.dart` :Handles **new user registration**.Collects user details and creates a secure account in Firestore.  

`medisure/lib/screens/status.dart`: Displays the **current health status**. Could summarize key vitals like SpO2, glucose, BP, etc.  

`medisure/lib/screens/test_status.dart`: Shows **results of the latest test performed**. Example: after a SpO2 or glucose test, results are displayed here.  

---

## ✨ Features – `medisure/lib/screens/`

- 🖥️ **User Interaction** → Each screen manages a unique part of the app’s workflow.  
- 🔗 **Navigation** → Smooth transitions between login, signup, test results, and records.  
- 📊 **Health Visualization** → Screens dedicated to monitoring and tracking vitals.  
- 👤 **Personalization** → Profile management and editable user data.  

---

### 📱 App Navigation Storyboard 
```bash
🚀 App Launch
      |
      v
🔑 Login Screen ---------> 📝 Signup Screen
      |                        |
      |                        v
      |                 👤 Account Created 
      v
🔒 Forgot Password Screen (optional)
      |
      v
📊 Status Screen ---> 🫁 SpO2 Screen ---> 🔄 Refresh Data 
      |                     |
      |                     v
      |                 💾 Save Data 
      |
      v
📊 Status Screen ---> 🍬 Glucose Screen ---> 🔄 Refresh Data 
      |                      |
      |                      v
      |                  💾 Save Data 
      v
📜 History ---> 📂 Past Records
      |
      v
📊 Status Screen ---> 👤 Profile Edit Screen ---> 📤 Upload Photo
                              |
                              v
                        💾 Save Changes 
```

## <img src="https://github.com/user-attachments/assets/1aafab50-1305-47c4-87ab-40a9d64f3067" alt="contribution gif" width="35"/> Contribution Guide  

1️⃣ **Fork the repository**  
Click on the **<img src="https://img.icons8.com/ios-filled/20/000000/code-fork.png" alt="fork icon"/> (fork)** button at the top-right corner of this repository to create a copy under your GitHub account.


2️⃣ **Clone your fork**  
Clone your forked repository to your local machine.  
```bash
git clone https://github.com/rutvikbarbhai/Medisure_Software_Application.git
cd Medisure_Software_Application/medisure
```
3️⃣ **Create a feature branch**
Always create a new branch for your feature/fix instead of working directly on main.
```bash
git checkout -b feature-name
```
4️⃣ **Commit your changes**
After making changes, stage and commit them with a descriptive message.
```bash
git add .
git commit -m "Add feature: <short description>"
```
5️⃣ **Push to your branch**
Push the branch to your forked repository.
```bash
git push origin feature-name
```
6️⃣ **Open a Pull Request**
- Go to your forked repository on GitHub.
- Click Compare & pull request.
- Provide a clear title and description of the changes.
- Submit the Pull Request for review 🚀.

## <img src="https://github.com/user-attachments/assets/233e326b-1812-456b-86f8-27599a0a88bf" alt="stay updated gif" width="40"/>Accessing the Application  
You can access the corresponding application for this project by visiting the link provided below:  
### 📥 How to Access the Release  
You can download and test the **Medisure Health App (APK)** in two ways:  

[![Latest Release v1.0.0](https://img.shields.io/badge/release-v1.0.0-blue?style=for-the-badge)](https://github.com/rutvikbarbhai/Project-Medisure-Device-And-Method-For-Monitoring-Blood-Parameters-of-a-User./releases/download/v1.0.0/Medisure.apk)



- 👉 **Direct Download**: [Click here to download the APK](https://github.com/rutvikbarbhai/Project-Medisure-Device-And-Method-For-Monitoring-Blood-Parameters-of-a-User./releases/download/v1.0.0/Medisure.apk)
- 👉 Or go to the [Releases Page](https://github.com/rutvikbarbhai/Project-Medisure-Device-And-Method-For-Monitoring-Blood-Parameters-of-a-User./releases/tag/v1.0.0) to view all assets and details.  

<img src="https://github.com/user-attachments/assets/64abffeb-9a67-4e47-a3ec-69036aa3a343" height="30px" style="position: bottom;"> **Note**: The APK is for testing purposes only. To install on Android, enable *Install from Unknown Sources* in your device settings.  


## <img src="https://github.com/user-attachments/assets/cdf0c0db-ffba-4353-9c40-da391fa70779" alt="stay updated gif" height="35px" style="vertical-align:text-bottom;"> Stay Updated
This README will be updated regularly as the project progresses.  
  
