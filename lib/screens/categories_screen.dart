import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../services/storage_service.dart';

class CategoriesScreen extends StatefulWidget {
  final List<TaskCategory> categories;

  const CategoriesScreen({super.key, required this.categories});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final StorageService _storage = StorageService();

  // Controller for category name input
  final _nameController = TextEditingController();

  // Available colors for categories
  final List<Color> _availableColors = [
    Colors.redAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.deepPurple,
    Colors.teal,
    Colors.cyan,
  ];
  Color _selectedColor = Colors.blueAccent;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  /// Adds a new category
  void _addCategory() {
    // Reset form
    _nameController.clear();
    _selectedColor = Colors.blueAccent;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        title: const Text("Add Category"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Category name input
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                hintText: "e.g., Work, Personal, etc.",
              ),
            ),
            const SizedBox(height: 20),

            // Color picker
            const Text(
              "Choose Color:",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: _availableColors.map((color) {
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedColor = color);
                  },
                  child: CircleAvatar(
                    backgroundColor: color,
                    radius: 20,
                    child: _selectedColor == color
                        ? const Icon(Icons.check, size: 18, color: Colors.white)
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
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              // Validate name
              if (_nameController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Enter category name!'),
                    backgroundColor: Colors.redAccent,
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }

              // for new category
              final newCat = TaskCategory(
                id: DateTime.now().toString(),
                name: _nameController.text.trim(),
                colorValue: _selectedColor.toARGB32(),
              );

              // Add category and save
              widget.categories.add(newCat);
              _storage.saveCategories(widget.categories);
              Navigator.of(ctx).pop();

              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('"${newCat.name}" category added'),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );

              setState(() {}); // Refresh UI
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  /// Deletes a category
  void _deleteCategory(int index) {
    final categoryName = widget.categories[index].name;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Category?"),
        content: Text('Remove "$categoryName" category?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.categories.removeAt(index);
                _storage.saveCategories(widget.categories);
              });
              Navigator.of(ctx).pop();

              // Show success message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('"$categoryName" deleted'),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Categories"), centerTitle: true),
      body: widget.categories.isEmpty
          ? const Center(
              child: Text(
                "No categories yet.\nCreate your first one!",
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
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
