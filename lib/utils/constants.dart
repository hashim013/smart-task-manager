import 'package:flutter/material.dart';

/// App color constants
class AppColors {
  static const Color highPriority = Colors.red;
  static const Color mediumPriority = Colors.yellow;
  static Color lowPriority = Colors.greenAccent[700]!;

  static const Color primary = Colors.blueAccent;
  static const Color error = Colors.redAccent;
  static const Color success = Colors.green;

  static const Color darkBg = Color(0xFF121212);
  static const Color darkCard = Color(0xFF1E1E1E);
}

/// App text strings
class AppStrings {
  static const String appName = 'Smart Task Manager';
  static const String tasksTitle = 'TASKS';
  static const String searchHint = 'Search tasks...';
  static const String noTasksFound = 'No tasks found!';
  static const String taskNameEmpty = 'Task name cannot be empty!';
  static const String errorLoadingData = 'Error loading data: ';
  static const String errorSavingTask = 'Error saving task: ';
  static const String deleted = 'Deleted';
  static const String undo = 'UNDO';
  static const String addCategory = 'Add';
  static const String categoryName = 'Name';
  static const String categoryHint = 'e.g., Work, Personal, etc.';
  static const String chooseColor = 'Choose Color:';
  static const String editTask = 'Edit task';
  static const String deleteTask = 'Delete task';
  static const String today = 'Today';
  static const String addTask = 'ADD TASK';
  static const String editTaskTitle = 'EDIT TASK';
  static const String update = 'UPDATE';
  static const String save = 'SAVE';
  static const String cancel = 'CANCEL';
  static const String enterCategoryName = 'Enter category name!';
  static const String categoryAdded = 'category added';
  static const String categoryDeleted = 'deleted';
  static const String deleteCategory = 'Delete Category?';
  static const String deleteCategoryConfirm = 'Remove';
  static const String editCategories = 'Edit Categories';
  static const String noCategoriesYet =
      'No categories yet.\n Create your first one!';
  static const String category = 'Category';
  static const String noCategory = 'No Category';
  static const String dueDate = 'Due Date:';
  static const String priority = 'Priority';
  static const String taskName = 'Task Name';
  static const String description = 'Description';
}

/// Priority levels
class PriorityLevels {
  static const String high = 'High';
  static const String medium = 'Medium';
  static const String low = 'Low';

  static const List<String> all = [high, medium, low];
}

class AppDurations {
  static const Duration snackBarDuration = Duration(seconds: 3);
  static const Duration autoCloseDuration = Duration(seconds: 4);
  static const Duration shortAnimation = Duration(milliseconds: 300);
}

class DefaultCategories {
  static const Map<String, dynamic> personal = {
    'id': '1',
    'name': 'Personal',
    'colorValue': 0xFFFF5252,
  };

  static const Map<String, dynamic> college = {
    'id': '2',
    'name': 'College',
    'colorValue': 0xFF448AFF,
  };

  static const Map<String, dynamic> health = {
    'id': '3',
    'name': 'Health',
    'colorValue': 0xFF69F0AE,
  };
}
