import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';
import '../models/category_model.dart';
import '../utils/constants.dart';

/// Service for storing and retrieving tasks and categories
class StorageService {
  static const String _tasksKey = 'task_final';
  static const String _catsKey = 'categories_final';

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final String data = jsonEncode(tasks.map((t) => t.toMap()).toList());
    await prefs.setString(_tasksKey, data);
  }

  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_tasksKey);
    if (data == null) return [];
    final List<dynamic> decoded = jsonDecode(data);
    return decoded.map((item) => Task.fromMap(item)).toList();
  }

  Future<void> saveCategories(List<TaskCategory> categories) async {
    final prefs = await SharedPreferences.getInstance();
    final String data = jsonEncode(categories.map((c) => c.toMap()).toList());
    await prefs.setString(_catsKey, data);
  }

  Future<List<TaskCategory>> loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_catsKey);

    if (data == null) {
      return [
        TaskCategory(
          id: DefaultCategories.personal['id'],
          name: DefaultCategories.personal['name'],
          colorValue: DefaultCategories.personal['colorValue'],
        ),
        TaskCategory(
          id: DefaultCategories.college['id'],
          name: DefaultCategories.college['name'],
          colorValue: DefaultCategories.college['colorValue'],
        ),
        TaskCategory(
          id: DefaultCategories.health['id'],
          name: DefaultCategories.health['name'],
          colorValue: DefaultCategories.health['colorValue'],
        ),
      ];
    }

    final List<dynamic> decoded = jsonDecode(data);
    return decoded.map((item) => TaskCategory.fromMap(item)).toList();
  }
}
