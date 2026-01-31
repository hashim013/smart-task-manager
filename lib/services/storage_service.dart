import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';
import '../models/category_model.dart';

/// Service for storing and retrieving tasks and categories
class StorageService {
  static const String _tasksKey = 'task_final';
  static const String _catsKey = 'categories_final';

  /// Saves list of tasks to local storage
  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final String data = jsonEncode(tasks.map((t) => t.toMap()).toList());
    await prefs.setString(_tasksKey, data);
  }

  /// Loads tasks from local storage
  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_tasksKey);
    if (data == null) return [];
    final List<dynamic> decoded = jsonDecode(data);
    return decoded.map((item) => Task.fromMap(item)).toList();
  }

  /// Saves list of categories to local storage
  Future<void> saveCategories(List<TaskCategory> categories) async {
    final prefs = await SharedPreferences.getInstance();
    final String data = jsonEncode(categories.map((c) => c.toMap()).toList());
    await prefs.setString(_catsKey, data);
  }

  /// Loads categories from local storage
  Future<List<TaskCategory>> loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_catsKey);

    if (data == null) {
      return [
        TaskCategory(id: '1', name: 'Personal', colorValue: 0xFFFF5252),
        TaskCategory(id: '2', name: 'College', colorValue: 0xFF448AFF),
        TaskCategory(id: '3', name: 'Health', colorValue: 0xFF69F0AE),
      ];
    }

    final List<dynamic> decoded = jsonDecode(data);
    return decoded.map((item) => TaskCategory.fromMap(item)).toList();
  }
}
