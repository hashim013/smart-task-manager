class Task {
  String id;
  String title;
  String description;
  String? categoryId;
  String priority;
  bool isCompleted;
  DateTime date;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.categoryId,
    required this.priority,
    this.isCompleted = false,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'categoryId': categoryId,
      'priority': priority,
      'isCompleted': isCompleted,
      'date': date.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      categoryId: map['categoryId'],
      priority: map['priority'] ?? 'Low',
      isCompleted: map['isCompleted'] ?? false,
      date: DateTime.parse(map['date']),
    );
  }
}
