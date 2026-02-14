import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';
import '../models/category_model.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import 'categories_screen.dart';

class AddTaskScreen extends StatefulWidget {
  final List<TaskCategory> categories;
  final Task? task;

  const AddTaskScreen({super.key, required this.categories, this.task});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  String? _selectedCategoryId;
  String _selectedPriority = 'Low';
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descController.text = widget.task!.description;
      _selectedCategoryId = widget.task!.categoryId;
      _selectedPriority = widget.task!.priority;
      _selectedDate = widget.task!.date;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  /// date picker
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

  void _save() {
    try {
      if (_titleController.text.trim().isEmpty) {
        AppHelpers.showError(context, AppStrings.taskNameEmpty);
        return;
      }

      // new or updated task
      final newTask = Task(
        id: widget.task?.id ?? DateTime.now().toString(),
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        categoryId: _selectedCategoryId,
        priority: _selectedPriority,
        date: _selectedDate,
        isCompleted: widget.task?.isCompleted ?? false,
      );

      // Return new/updated task with categories
      Navigator.of(
        context,
      ).pop({'task': newTask, 'categories': widget.categories});
    } catch (e) {
      AppHelpers.showError(context, '${AppStrings.errorSavingTask}$e');
    }
  }

  void _openCategoryManager() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CategoriesScreen(categories: widget.categories),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.task != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? AppStrings.editTaskTitle : AppStrings.addTask),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCustomTextField(_titleController, AppStrings.taskName),
            const SizedBox(height: 15),

            _buildCustomTextField(
              _descController,
              AppStrings.description,
              maxLines: 3,
            ),
            const SizedBox(height: 25),

            const Text(
              AppStrings.category,
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
                        hint: const Text(AppStrings.noCategory),
                        dropdownColor: Theme.of(context).cardColor,
                        items: [
                          const DropdownMenuItem<String>(
                            value: null,
                            child: Text(
                              AppStrings.noCategory,
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

                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: _openCategoryManager,
                ),
              ],
            ),

            const SizedBox(height: 15),

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
                      AppStrings.dueDate,
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

            const Text(
              AppStrings.priority,
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
                  items: PriorityLevels.all
                      .map(
                        (p) => DropdownMenuItem(
                          value: p,
                          child: Text(
                            p,
                            style: TextStyle(
                              color: AppHelpers.getPriorityColor(p),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (val) => setState(() => _selectedPriority = val!),
                ),
              ),
            ),

            const SizedBox(height: 40),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: _save,
                    child: Text(
                      isEdit ? AppStrings.update : AppStrings.save,
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
                      backgroundColor: AppColors.error,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      AppStrings.cancel,
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
