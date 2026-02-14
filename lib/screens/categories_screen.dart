import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../services/storage_service.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';

class CategoriesScreen extends StatefulWidget {
  final List<TaskCategory> categories;

  const CategoriesScreen({super.key, required this.categories});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final StorageService _storage = StorageService();

  final _nameController = TextEditingController();

  final List<Color> _availableColors = [
    AppColors.highPriority,
    AppColors.primary,
    AppColors.lowPriority,
    Colors.deepPurple,
    Colors.teal,
    Colors.cyan,
  ];
  Color _selectedColor = AppColors.primary;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  /// Adds a new category
  void _addCategory() {
    _nameController.clear();
    _selectedColor = AppColors.primary;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: const Text(AppStrings.addCategory),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: AppStrings.categoryName,
                  hintText: AppStrings.categoryHint,
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                AppStrings.chooseColor,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: _availableColors.map((color) {
                  return GestureDetector(
                    onTap: () {
                      setDialogState(() => _selectedColor = color);
                    },
                    child: CircleAvatar(
                      backgroundColor: color,
                      radius: 20,
                      child: _selectedColor.value == color.value
                          ? Icon(
                              Icons.check_circle,
                              size: 28,
                              color: color.computeLuminance() > 0.5
                                  ? Colors.black
                                  : Colors.white,
                            )
                          : null,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text(AppStrings.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.trim().isEmpty) {
                  AppHelpers.showError(
                    context,
                    AppStrings.enterCategoryName,
                    duration: const Duration(seconds: 2),
                  );
                  return;
                }

                final newCat = TaskCategory(
                  id: DateTime.now().toString(),
                  name: _nameController.text.trim(),
                  colorValue: _selectedColor.value,
                );

                widget.categories.add(newCat);
                _storage.saveCategories(widget.categories);
                Navigator.of(ctx).pop();

                AppHelpers.showSuccess(
                  context,
                  '"${newCat.name}" ${AppStrings.categoryAdded}',
                );

                setState(() {});
              },
              child: const Text(AppStrings.addCategory),
            ),
          ],
        ),
      ),
    );
  }

  /// Delete a category
  void _deleteCategory(int index) {
    final categoryName = widget.categories[index].name;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppStrings.deleteCategory),
        content: Text(
          '${AppStrings.deleteCategoryConfirm} "$categoryName" ${AppStrings.category.toLowerCase()}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.categories.removeAt(index);
                _storage.saveCategories(widget.categories);
              });
              Navigator.of(ctx).pop();

              // Shows deletion message
              AppHelpers.showSuccess(
                context,
                '"$categoryName" ${AppStrings.categoryDeleted}',
              );
            },
            child: const Text(AppStrings.deleteCategoryConfirm),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.editCategories),
        centerTitle: true,
      ),
      body: widget.categories.isEmpty
          ? const Center(
              child: Text(
                AppStrings.noCategoriesYet,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: widget.categories.length,
              itemBuilder: (ctx, i) {
                final cat = widget.categories[i];
                return ListTile(
                  leading: CircleAvatar(backgroundColor: cat.color, radius: 10),
                  title: Text(cat.name),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteCategory(i),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCategory,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
