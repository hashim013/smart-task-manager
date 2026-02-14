import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:smart_task_manager/main.dart';
import '../models/task.dart';
import '../models/category_model.dart';
import '../services/storage_service.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const HomeScreen({super.key, required this.toggleTheme});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

/// Home Screen
/// Displays all tasks, handles search, delete, and navigation

class HomeScreenState extends State<HomeScreen> {
  final StorageService _storage = StorageService();
  final TextEditingController _searchController = TextEditingController();

  List<Task> _allTasks = [];
  List<Task> _filteredTasks = [];
  List<TaskCategory> _categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      final t = await _storage.loadTasks();
      final c = await _storage.loadCategories();
      setState(() {
        _allTasks = t;
        _categories = c;
        _filteredTasks = t;
        _sortTasks();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: Text('${AppStrings.errorLoadingData}$e'),
            backgroundColor: AppColors.error,
            duration: AppDurations.snackBarDuration,
          ),
        );
      }
    }
  }

  void _sortTasks() {
    _filteredTasks.sort((a, b) {
      int rankA = AppHelpers.getPriorityRank(a.priority);
      int rankB = AppHelpers.getPriorityRank(b.priority);
      if (rankA != rankB) return rankA.compareTo(rankB);
      return a.date.compareTo(b.date);
    });
  }

  void _runFilter(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        _filteredTasks = _allTasks;
      } else {
        _filteredTasks = _allTasks
            .where((t) => t.title.toLowerCase().contains(keyword.toLowerCase()))
            .toList();
      }
      _sortTasks();
    });
  }

  /// Saves all tasks and categories to local storage
  void _saveAll() {
    _storage.saveTasks(_allTasks);
    _storage.saveCategories(_categories);
  }

  void _openTaskForm({Task? task}) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AddTaskScreen(categories: _categories, task: task),
      ),
    );

    if (result != null) {
      setState(() {
        if (task == null) {
          _allTasks.add(result['task']);
        } else {
          final index = _allTasks.indexWhere((t) => t.id == task.id);
          if (index != -1) _allTasks[index] = result['task'];
        }
        _categories = result['categories'];
        _runFilter(_searchController.text);
        _saveAll();
      });
    }
  }

  /// Deletes a task with UNDO option
  void _deleteTask(Task task) {
    final deletedIndex = _allTasks.indexOf(task);

    scaffoldMessengerKey.currentState?.removeCurrentSnackBar();

    final snackBarController = scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text("${AppStrings.deleted} '${task.title}'"),
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.horizontal,
        action: SnackBarAction(
          label: AppStrings.undo,
          onPressed: () {
            setState(() {
              _allTasks.insert(deletedIndex, task);
              _runFilter(_searchController.text);
              _saveAll();
            });
          },
        ),
      ),
    );

    // Auto-dismiss snackbar
    Future.delayed(AppDurations.autoCloseDuration, () {
      try {
        snackBarController?.close();
      } catch (e) {}
    });

    setState(() {
      _allTasks.remove(task);
      _runFilter(_searchController.text);
      _saveAll();
    });
  }

  TaskCategory? _getCategory(String id) {
    if (_categories.isEmpty) return null;
    try {
      return _categories.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  Color _getPriorityColor(String priority) {
    return AppHelpers.getPriorityColor(priority);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          AppStrings.tasksTitle,
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
        actions: [
          IconButton(
            onPressed: widget.toggleTheme,
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              onChanged: _runFilter,
              decoration: InputDecoration(
                hintText: AppStrings.searchHint,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _runFilter('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredTasks.isEmpty
                ? const Center(child: Text(AppStrings.noTasksFound))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: _filteredTasks.length,
                    itemBuilder: (ctx, i) {
                      final task = _filteredTasks[i];
                      // Get category for the task
                      final cat = task.categoryId != null
                          ? _getCategory(task.categoryId!)
                          : null;
                      final isToday = DateUtils.isSameDay(
                        task.date,
                        DateTime.now(),
                      );
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border(
                            left: BorderSide(
                              color: _getPriorityColor(task.priority),
                              width: 4,
                            ),
                          ),
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: task.isCompleted,
                            activeColor: AppColors.primary,
                            onChanged: (val) => setState(() {
                              task.isCompleted = val!;
                              _saveAll();
                            }),
                          ),
                          title: Text(
                            task.title,
                            style: TextStyle(
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                              fontWeight: FontWeight.bold,
                              color: task.isCompleted ? Colors.grey : null,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (task.description.isNotEmpty)
                                Text(
                                  task.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  if (cat != null) ...[
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: cat.color.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        cat.name.toUpperCase(),
                                        style: TextStyle(
                                          color: cat.color,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                  Text(
                                    isToday
                                        ? AppStrings.today
                                        : DateFormat.MMMd().format(task.date),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isToday ? Colors.red : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: AppColors.primary,
                                  ),
                                  tooltip: AppStrings.editTask,
                                  onPressed: () => _openTaskForm(task: task),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: AppColors.error,
                                  ),
                                  tooltip: AppStrings.deleteTask,
                                  onPressed: () => _deleteTask(task),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTaskForm(),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
