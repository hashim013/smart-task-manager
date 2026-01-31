
# 📌 Smart Task Manager (Flutter)

A simple, clean, and beginner-friendly **Flutter Todo Application** that helps users manage daily tasks with categories, priorities, and local storage support.

This project focuses on **stability, good UX, and clean architecture**, making it suitable for students and new Flutter developers.

---

## 🚀 Features

* ✅ Add, edit, and delete tasks
* ✅ Assign categories with custom colors
* ✅ Set priority levels (Low, Medium, High)
* ✅ Select due dates
* ✅ Mark tasks as completed
* ✅ Search tasks instantly
* ✅ Undo delete using SnackBar
* ✅ Dark & Light theme support
* ✅ Splash screen with fallback image
* ✅ Local data storage using SharedPreferences
* ✅ Input validation & error handling

---

## 📱 App Preview

> The app starts with a splash screen, then opens the task dashboard where users can manage their tasks easily.

---

## 🏗️ Project Structure

```
lib/
│
├── main.dart
│
├── models/
│   ├── task.dart
│   └── category_model.dart
│
├── screens/
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── add_task_screen.dart
│   └── categories_screen.dart
│
└── services/
    └── storage_service.dart
```

### Folder Description

| Folder    | Purpose                              |
| --------- | ------------------------------------ |
| models    | Data models for tasks and categories |
| screens   | UI screens of the application        |
| services  | Handles data storage and retrieval   |
| main.dart | App entry point & theme management   |

---

## 🛠️ Technologies Used

* Flutter (Material Design)
* Dart
* SharedPreferences (Local Storage)
* Intl (Date Formatting)

---

## 📂 Data Storage

This app uses **SharedPreferences** to store data locally.

* Tasks and categories are converted into JSON format
* Stored using keys
* Loaded on app startup
* Automatically saved on changes

Example:

```dart
jsonEncode(tasks.map((t) => t.toMap()).toList());
```

---

## ⚙️ Installation & Setup

### Prerequisites

* Flutter SDK installed
* Android Studio / VS Code
* Android Emulator or Physical Device

---

### Steps

1️⃣ Clone the repository

```bash
git clone https://github.com/your-username/smart-task-manager.git
```

2️⃣ Navigate to project folder

```bash
cd smart-task-manager
```

3️⃣ Clean and get dependencies

```bash
flutter clean
flutter pub get
```

4️⃣ Analyze project

```bash
flutter analyze
```

5️⃣ Run the app

```bash
flutter run
```

---

## 🧪 Testing & Validation

The app includes built-in validation and error handling:

✔ Empty task title handling
✔ Safe null checks for categories
✔ Try-catch blocks for storage
✔ Snackbar feedback
✔ Controller disposal

Test cases:

* Create task without category → No crash
* Delete task → Undo appears
* Restart app → Data persists
* Empty input → Validation shown

---

## 🧠 Key Logic

### Home Screen

* Loads tasks & categories
* Handles filtering & sorting
* Manages deletion & undo

### Add Task Screen

* Form validation
* Date picker
* Priority selector
* Category manager

### Storage Service

* Converts data to JSON
* Saves to SharedPreferences
* Loads on startup

---

## ⚠️ Challenges Faced & Solutions

| Challenge           | Solution                 |
| ------------------- | ------------------------ |
| Null-safety crash   | Added safe null checks   |
| Snackbar stuck      | Added duration & control |
| App crashes on load | Added try-catch          |
| Memory leaks        | Disposed controllers     |
| Image loading error | Added fallback icon      |

---

## 👨‍💻 Why This Project?

This project was developed as a task assigned during the ITSOLERA Winter Internship 2026 (Mobile App Development).

The main purpose of this project was to:

* Apply Flutter concepts in a real-world application
* Practice mobile app development using Dart and Material UI
* Learn proper project structure and state management
* Implement local data storage using SharedPreferences
* Improve debugging and problem-solving skills
* Understand null-safety and error handling in Flutter

Through this internship task, I gained hands-on experience in building a complete, stable, and user-friendly mobile application.

---

## 🌟 Future Improvements

* Cloud backup (Firebase)
* User authentication
* Task reminders
* Push notifications
* Analytics dashboard

---

## 🤝 Contributing

Contributions are welcome!

If you want to improve this project:

1. Fork the repo
2. Create a new branch
3. Make changes
4. Submit a pull request

---

## 📄 License

This project is open-source and available under the **MIT License**.

---

## 🙋 Author

**Muhammad Hashim**
Flutter Developer | Student | Learner

📧 Feel free to connect and contribute.

---

## ⭐ Support

If you like this project:

🌟 Star the repository
🍴 Fork it
📢 Share with others

