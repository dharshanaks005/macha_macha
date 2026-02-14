<p align="center">
  <img src="./img.png" alt="Project Banner" width="100%">
</p>

# [Project Name] 🎯
MachaMacha
Solve real problems with real people -instantly.
## Basic Details

### Team Name: Cotton Candy

### Team Members
- Member 1: Dharshana K S- Government Engineering College Thrissur
- Member 2: Maria Denny- Government Engineering College Thrissur

### Hosted Project Link
This is our APK File
https://drive.google.com/file/d/1MghEboihBTcxTWFMFxOFZd_7aP9mz2j5/view?usp=sharing

### Project Description
MachaMacha is a real-time peer-to-peer micro mentoring platform that connects users instantly for focused 15-minute problem-solving sessions. It combines speed, accountability, and human connection to deliver meaningful support when it matters most.

### The Problem statement
In today’s digital world, information is everywhere — AI tools provide instant answers and forums provide community discussions. Yet users still struggle with real-time human guidance, emotional clarity, and accountability.

Answers can be generic, delayed, noisy, or unreliable. There is no structured system that guarantees instant, private, and responsible one-to-one support.

### The Solution
MachaMacha introduces a structured 15-minute real-time human support system.
When a user posts a request:
The first available helper is matched using a Firestore transaction-based First-Come-First-Serve (FCFS) algorithm
A private one-to-one chat session begins
After 15 minutes, the session ends
Both users rate each other
Reliability is built through performance, not popularity.

---

## Technical Details

### Technologies/Components Used
Technologies Used:
-Flutter
-Firebase Authentication
-Cloud Firestore
-Real-time database listeners
-Firestore transactions for FCFS matching

**For Software:**
- Languages used: Dart
- Frameworks used: Flutter
- Libraries used: Firebase Authentication, Cloud Firestore, Flutter Material UI
- Tools used: VS Code, Android Studio, Firebase Console, Git, GitHub

---

## Features
List the key features of your project:
- Feature 1: Instant help request posting with FCFS real-time matching
- Feature 2: Private one-to-one chat with 15-minute structured sessions
- Feature 3: Reliability and rating system
- Feature 4: Emotional support through real human interaction

---

## Implementation

### For Software:
#### Installation
clone the repository. then type this into the commandline in root directory
or download the given apk file.

#### Run
```bash
flutter run
```
flutter run in the root directory
Build APK-- flutter build apk
---

## Project Documentation

### For Software:

#### Screenshots (Add at least 3)

![profile_page](https://github.com/user-attachments/assets/cf5d41bc-dbf5-4dd1-a93e-e13b89559c7f)
PROFILE PAGE- This is the profile page in which the user and his/her details are shown along with karma points which is a pay-it-forward system we plan to add on to the future enhancements of our project and it also shows the requests we gave.

![request_help](https://github.com/user-attachments/assets/06afe4bd-bb22-47ed-9336-db70b6de4690)
REQUEST_HELP PAGE- When a user wants to seek help for doing any task or learning a microskill then they can use the add button in requests_feed page and then add a new request and categorise it according to its type and level.

![requests_feed](https://github.com/user-attachments/assets/7a559e0c-0d27-46ce-87f4-8eb2b2b57b8c)
REQUESTS_FEED PAGE- When a user logins with their registered email id and password this page is what they see and when they click on Help button then it redirects to a chat with the person who posted the request.


#### Diagrams

**System Architecture:**
MachaMacha follows a client–server architecture using Flutter as the frontend and Firebase as the backend.
The Flutter mobile application handles all user interactions including authentication, request creation, chat sessions, timers, and ratings. Firebase Authentication manages secure user login and identity verification. Cloud Firestore acts as the real-time database, storing users, requests, sessions, chat messages, ratings, and reviews.
When a user creates a help request, it is stored in Firestore and instantly becomes visible to other users. Session creation and First-Come-First-Serve (FCFS) matching are handled using Firestore atomic transactions to prevent race conditions. Real-time chat updates are streamed from Firestore to both users simultaneously.
After a 15-minute session ends, ratings and reviews are written back to Firestore, updating user reliability scores.
This architecture ensures real-time communication, scalability, data consistency, and low latency without requiring a custom backend server.
![architechture](https://github.com/user-attachments/assets/baa13a45-7242-4f11-b0d0-07986d7c0fe5)


**Application Workflow:**
![workflow](https://github.com/user-attachments/assets/80665e6b-ca8e-402f-ad66-c6484f54365e)
Application Workflow – MachaMacha
When the app launches, the Splash Screen initializes Firebase and checks if a user is already logged in using Firebase Authentication.
If the user is authenticated → they are redirected to the Home Page
If not → they are taken to the Sign In / Sign Up screen
Authentication is handled using Firebase Auth, which securely manages login, registration, and session persistence.
Once logged in, the user reaches the Home Page, which is connected to Cloud Firestore using real-time listeners (StreamBuilder). This allows live updates of help requests.
Users can:
Post a help request (stored in Firestore)
View other users’ requests in real time
Accept a request (FCFS logic using Firestore transaction)
Enter a private one-to-one chat session
After the session, both users can rate each other.
This architecture ensures secure authentication, real-time updates, and structured peer-to-peer interaction.

---


### For Mobile Apps:

#### App Flow Diagram

![Appflow](https://github.com/user-attachments/assets/777a9f09-d4a4-49fd-bea2-4cf71f955c4c)
When the APK is installed on your mobilephone , the first thing that pops up is a splashscreen written as 'MACHAMACHA' with our logo.
Then it leads to a Sign-in or Sign-up page which has proper backend using firebase.Then as the user is logged in they are first directed to the requests_feed page in which they can other users request or they can add a request of their own and the last page is the Profile page in which the user can see the requests they have given and its status whether any other user has accepted it and if so then it redirects it to a chat between these users ,connectiong them.

#### Installation Guide

**For Android (APK):**
1. Download the APK from [Release Link]
2. Enable "Install from Unknown Sources" in your device settings:
   - Go to Settings > Security
   - Enable "Unknown Sources"
3. Open the downloaded APK file
4. Follow the installation prompts
5. Open the app and enjoy!

**For iOS (IPA) - TestFlight:**
1. Download TestFlight from the App Store
2. Open this TestFlight link: [Your TestFlight Link]
3. Click "Install" or "Accept"
4. Wait for the app to install
5. Open the app from your home screen

**Building from Source:**
```bash
# For Android
flutter build apk
# or
./gradlew assembleDebug

# For iOS
flutter build ios
# or
xcodebuild -workspace App.xcworkspace -scheme App -configuration Debug
```

---


## Project Demo

### Video
[Add your demo video link here - YouTube, Google Drive, etc.]
https://drive.google.com/file/d/1ps9n_QTaJieHckoPlLWYX8N4qt1ayuF9/view?usp=sharing
It explains the working of the app with the help of microsoft edge as an emulator device in our flutter project.

### Additional Demos
[Add any extra demo materials/links - Live site, APK download, online demo, etc.]

---

## AI Tools Used (Optional - For Transparency Bonus)
If you used AI tools during development, document them here for transparency:

**Tool Used:** ChatGPT,FigmaAI

**Purpose:** 
- ChatGPT was used in the creation of flutter files and its firebase integration .


**Key Prompts Used:**
- "why does my flutter app load to a red screen image telling its an error"
- "Debug this future<void> function that's giving an error"


**Percentage of AI-generated code:** [Approximately X%]

**Human Contributions:**
- Architecture design and planning
- Custom business logic implementation
- Integration and testing
- UI/UX design decisions

*Note: Proper documentation of AI usage demonstrates transparency and earns bonus points in evaluation!*

---

## Team Contributions

- Maria Denny - UI Design, Flutter ,Frontend.
- Dharshana K S - Firebase initialisation,Firebase database creation and use in app.

## License

This project is licensed under the [LICENSE_NAME] License - see the [LICENSE](LICENSE) file for details.

**Common License Options:**
- MIT License (Permissive, widely used)
- Apache 2.0 (Permissive with patent grant)
- GPL v3 (Copyleft, requires derivative works to be open source)

---

Made with ❤️ at TinkerHub
