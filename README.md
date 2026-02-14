# 📱 Smart Task Manager – Flutter App

A clean, modern, and beginner-friendly **Task Management Flutter application** that helps users organize daily tasks with categories, priorities, and persistent local storage.

Built with focus on **clean architecture, good UI/UX, and stability** — perfect for students and Flutter learners.

---

## 🚀 Features

### 📝 Task Management

* Add, edit, and delete tasks
* Mark tasks as completed
* Instant task search
* Set due dates
* Undo delete with SnackBar

### 🗂️ Organization

* Create custom categories
* Assign colors to categories
* Filter tasks easily

### 🔥 Priority System

* 🔴 High priority
* 🟠 Medium priority
* 🟢 Low priority

### 🎨 UI & Theme

* Dark & Light mode
* Theme persistence
* Splash screen (theme supported)
* Clean Material UI

### 💾 Storage

* Local storage using SharedPreferences
* Works completely offline
* Data persists after restart

---

## 📸 App Flow

```
Splash Screen → Home Screen → Add/Edit Task → Save → Local Storage
```

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
├── services/
│   └── storage_service.dart
│
└── utils/
    ├── theme.dart
    ├── constants.dart
    └── helpers.dart
```

### 📌 Detailed Folder Explanation

For detailed folder explanation:
👉 See: [View Full Folder Structure](docs/FOLDER_STRUCTURE.md) 

---

## 🛠️ Technologies Used

* Flutter
* Dart
* Material Design
* SharedPreferences
* Intl

---

## ⚙️ Installation

### 1️⃣ Clone repository

```bash
git clone https://github.com/your-username/smart-task-manager.git
cd smart-task-manager
```

### 2️⃣ Install dependencies

```bash
flutter pub get
```

### 3️⃣ Run app

```bash
flutter run
```

---

## 🧠 Key Concepts Used

* StatefulWidget state management
* Theme switching
* Local storage with SharedPreferences
* Form validation
* SnackBar with undo
* Clean architecture
* Null-safe Flutter development

---

## 🧪 Stability & Error Handling

Handled common real-world issues:

| Issue               | Fix                           |
| ------------------- | ----------------------------- |
| Snackbar stuck      | Used global ScaffoldMessenger |
| Null category crash | Added fallback category       |
| Theme not updating  | Managed theme in main.dart    |
| Memory leaks        | Disposed controllers          |
| UI rebuild issues   | Optimized setState usage      |

---

## 👨‍💻 Why This Project?

This project was developed as part of the **ITSOLERA Winter Internship 2026 (Mobile App Development)**.

The main purpose of building this application was to:

* Apply Flutter concepts in a real-world application
* Practice mobile app development using Dart and Material UI
* Learn proper project structure and basic state management
* Implement local data storage using SharedPreferences
* Improve debugging and problem-solving skills
* Understand null-safety and error handling in Flutter

Through this internship task, I gained hands-on experience in building a complete, stable, and user-friendly mobile application while following clean coding practices and structured development.

---

## 💡 Challenges Faced

| Problem                   | Solution                 |
| ------------------------- | ------------------------ |
| Snackbar not disappearing | Global ScaffoldMessenger |
| Null crash on category    | Default fallback         |
| Theme issues              | Central theme controller |
| State bugs                | Proper setState usage    |

---

## 🔮 Future Improvements

* Firebase cloud backup
* Notifications & reminders
* User authentication
* Cloud sync
* Analytics dashboard

---

## 🤝 Contributing

This project was built for learning and internship practice,  
but suggestions and improvements are welcome.

If you'd like to contribute:

1. Fork the repository  
2. Create a new branch  
3. Make your changes  
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