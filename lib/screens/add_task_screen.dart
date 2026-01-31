import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';
import '../models/category_model.dart';
import 'categories_screen.dart';

class AddTaskScreen extends StatefulWidget {
  final List<TaskCategory> categories;
  final Task? task; // null if creating new task, otherwise editing

  const AddTaskScreen({super.key, required this.categories, this.task});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  // Form controllers
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  // Form state
  String? _selectedCategoryId;
  String _selectedPriority = 'Low';
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // If editing existing task, pre-fill form fields
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descController.text = widget.task!.description;
      _selectedCategoryId = widget.task!.categoryId;
      _selectedPriority = widget.task!.priority;
      _selectedDate = widget.task!.date;
    }
  }

  /// Clean up resources when screen is destroyed
  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  /// date picker to select due date
  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) =>
          Theme(data: Theme.of(context), child: child!),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  /// Validates and saves the task
  void _save() {
    try {
      if (_titleController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Task name cannot be empty!'),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      // Create task object
      final newTask = Task(
        id: widget.task?.id ?? DateTime.now().toString(),
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        categoryId: _selectedCategoryId,
        priority: _selectedPriority,
        date: _selectedDate,
        isCompleted: widget.task?.isCompleted ?? false,
      );

      // Return new/updated task to previous screen
      Navigator.of(
        context,
      ).pop({'task': newTask, 'categories': widget.categories});
    } catch (e) {
      // Show error message if saving fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving task: $e'),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  /// Opens category management screen
  void _openCategoryManager() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CategoriesScreen(categories: widget.categories),
      ),
    );
    setState(() {}); // Refresh UI in case categories changed
  }

  /// color based on priority level
  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.redAccent;
      case 'Medium':
        return Colors.yellow;
      default:
        return Colors.greenAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.task != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "EDIT TASK" : "ADD TASK")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCustomTextField(_titleController, "Task Name"),
            const SizedBox(height: 15),

            _buildCustomTextField(_descController, "Description", maxLines: 3),
            const SizedBox(height: 25),

            const Text(
              "Category",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedCategoryId,
                        hint: const Text("No Category"),
                        dropdownColor: Theme.of(context).cardColor,
                        items: [
                          const DropdownMenuItem<String>(
                            value: null,
                            child: Text(
                              "No Category",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          ...widget.categories.map(
                            (cat) => DropdownMenuItem(
                              value: cat.id,
                              child: Text(
                                cat.name,
                                style: TextStyle(color: cat.color),
                              ),
                            ),
                          ),
                        ],
                        onChanged: (val) =>
                            setState(() => _selectedCategoryId = val),
                      ),
                    ),
                  ),
                ),
                // Button to manage categories
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: _openCategoryManager,
                ),
              ],
            ),

            const SizedBox(height: 15),

            // Due date picker
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    const Text(
                      "Due Date:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(DateFormat.yMMMd().format(_selectedDate)),
                    const SizedBox(width: 10),
                    const Icon(Icons.calendar_today, size: 18),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Priority selection
            const Text(
              "Priority",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedPriority,
                  dropdownColor: Theme.of(context).cardColor,
                  items: ['Low', 'Medium', 'High']
                      .map(
                        (p) => DropdownMenuItem(
                          value: p,
                          child: Text(
                            p,
                            style: TextStyle(color: _getPriorityColor(p)),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (val) => setState(() => _selectedPriority = val!),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Save and Cancel buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: _save,
                    child: Text(
                      isEdit ? "UPDATE" : "SAVE",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      "CANCEL",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Custom styled text field
  Widget _buildCustomTextField(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(labelText: label, border: InputBorder.none),
      ),
    );
  }
}
