## <img src="https://github.com/user-attachments/assets/f3dcee8e-e008-457a-97fb-d3848b425713" height="30px" style="vertical-align:text-bottom;"> How to Navigate the Repository  
- `medisure/` → Flutter project source code  
- `README.md` → You are here (project guide)
## <img src="https://github.com/user-attachments/assets/847b75fa-3dcf-4ec8-acfb-4702827eeea7" height="30" style="vertical-align:text-bottom;"/>Project Structure 
```bash
project-name/
├── 📁 assets/           # Images, icons, static files
├── 📁 lib/              # Main source code
│   ├── 📁 screens/      # App screens (UI pages)
│   ├── 📁 widgets/      # Reusable UI components
│   ├── 📁 services/     # API calls, Firebase, Database
│   ├── 📁 models/       # Data models & structures
│   └── main.dart        # Entry point of the app
├── 📁 test/             # Unit & widget tests
├── pubspec.yaml         # Project configuration & dependencies
└── README.md            # Project documentation
```
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
  
