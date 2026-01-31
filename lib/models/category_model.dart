import 'package:flutter/material.dart';

class TaskCategory {
  String id;
  String name;
  int colorValue;

  TaskCategory({
    required this.id,
    required this.name,
    required this.colorValue,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'colorValue': colorValue};
  }

  factory TaskCategory.fromMap(Map<String, dynamic> map) {
    return TaskCategory(
      id: map['id'],
      name: map['name'],
      colorValue: map['colorValue'],
    );
  }

  Color get color => Color(colorValue);
}
