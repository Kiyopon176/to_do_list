class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});

  // Конвертация задачи в Map для сохранения
  Map<String, dynamic> toMap() {
    return {'title': title, 'isCompleted': isCompleted};
  }

  // Восстановление задачи из Map
  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      isCompleted: map['isCompleted'],
    );
  }
}
