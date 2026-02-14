# Smart Task Manager - Project Structure Guide 📁

A beginner-friendly Flutter application for managing tasks with categories and priority levels. This guide explains the project structure to help you navigate and understand the codebase.

## 📂 Folder Structure

```
lib/
├── main.dart                 # Entry point of the app
├── models/                   # Data models (classes that represent data)
│   ├── task.dart            # Task model class
│   └── category_model.dart  # TaskCategory model class
├── screens/                  # UI screens (pages/views)
│   ├── splash_screen.dart   # Splash/loading screen
│   ├── home_screen.dart     # Main tasks list screen
│   ├── add_task_screen.dart # Add/edit task form
│   └── categories_screen.dart # Manage categories
├── services/                # Business logic and data handling
│   └── storage_service.dart # Local storage operations (save/load data)
└── utils/                   # Utility files (helpers, constants, themes)
    ├── constants.dart       # App colors, strings, and constants
    ├── helpers.dart         # Helper functions
    └── theme.dart           # Theme configuration
```

## 🎯 File Descriptions

### **models/** - Data Models
These files define the structure of your data:

- **task.dart**: Defines the `Task` class
  - Properties: id, title, description, categoryId, priority, isCompleted, date
  - Methods: toMap(), fromMap() (for saving/loading from storage)

- **category_model.dart**: Defines the `TaskCategory` class
  - Properties: id, name, colorValue
  - Methods: toMap(), fromMap() (for saving/loading)

### **screens/** - User Interface Screens

- **main.dart**: Main app widget and theme management
  - Sets up light/dark themes
  - Manages theme switching with SharedPreferences
  - Displays home screen

- **home_screen.dart**: Main task list view
  - Displays all tasks in a list
  - Search and filter functionality
  - Edit (pencil icon) and delete (trash icon) buttons
  - Mark tasks as complete with checkbox
  - Add new task button (floating action button)

- **add_task_screen.dart**: Add/Edit task form
  - Form inputs for task title and description
  - Category selection
  - Priority level selection
  - Date picker for due date
  - Used for both creating new tasks and editing existing ones

- **splash_screen.dart**: Loading/splash screen
  - Displays while app initializes
  - Loads stored data in background

- **categories_screen.dart**: Category management
  - Add new categories
  - Delete categories
  - Choose colors for categories
  - Categories help organize tasks

### **services/** - Business Logic

- **storage_service.dart**: Handles all data persistence
  - `saveTasks()`: Save tasks to local storage
  - `loadTasks()`: Load tasks from local storage
  - `saveCategories()`: Save categories to local storage
  - `loadCategories()`: Load categories (or return default ones)
  - Uses SharedPreferences for local data storage

### **utils/** - Helper Files

- **constants.dart**: Centralized constants
  - `AppColors`: All color definitions
  - `AppStrings`: All text strings
  - `PriorityLevels`: Priority constants
  - `AppDurations`: Animation durations
  - `DefaultCategories`: Default category data

- **helpers.dart**: Utility functions
  - `getPriorityColor()`: Get color for priority level
  - `getPriorityRank()`: Get ranking for sorting
  - `isToday()`: Check if date is today
  - `isPastDate()`: Check if date is in past
  - `showSnackBar()`: Display messages
  - `showError()`: Display error messages
  - `showSuccess()`: Display success messages

- **theme.dart**: Theme configuration
  - `getLightTheme()`: Light theme setup
  - `getDarkTheme()`: Dark theme setup

## 🚀 How Data Flows

1. **App Start** → `main.dart` loads last saved theme
2. **Home Screen** → `home_screen.dart` loads tasks via `StorageService`
3. **Add/Edit Task** → Navigate to `add_task_screen.dart`
4. **Save Task** → Data saved via `StorageService.saveTasks()`
5. **Task Display** → Home screen updates with new task

## 💾 Local Storage

- Tasks and categories are saved to device using `SharedPreferences`
- Data persists even when app is closed
- Keys: `'task_final'` and `'categories_final'`

## 🎨 Key Features

- ✅ Add, edit, and delete tasks
- 📁 Organize tasks by categories
- 🔴 Priority levels (High, Medium, Low)
- ✓ Mark tasks as complete
- 🔍 Search and filter tasks
- 🌓 Dark and light themes
- 💾 Automatic data saving
- 📅 Date picker for due dates

## 🔧 Quick Tips for Beginners

1. **Models** = Blueprint of data (like a template)
2. **Screens** = What you see (UI/pages)
3. **Services** = Behind-the-scenes work (data handling)
4. **Utils** = Shared tools and configurations

## 📱 UI Components Used

- `ListView.builder`: Dynamic list of tasks
- `TextField`: Text input fields
- `Card`: Container with rounded corners
- `ListTile`: List item with leading, title, subtitle, trailing
- `Dialog`/`AlertDialog`: Pop-up windows
- `Checkbox`: Toggle completion status
- `FloatingActionButton`: Add new task button
- `IconButton`: Edit and delete buttons

## 🔌 Dependencies

- `flutter`: Core framework
- `cupertino_icons`: iOS-style icons
- `shared_preferences`: Local data storage
- `intl`: Date formatting

---

**Happy Coding! 🎉** For more help, check Flutter documentation at [flutter.dev](https://flutter.dev)
