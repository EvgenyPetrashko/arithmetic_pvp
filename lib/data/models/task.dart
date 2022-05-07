class Task {
  final int id;
  final String content;

  Task(
      {required this.id,
        required this.content});

  factory Task.fromJson(Map<String, dynamic> json) =>
      Task(
          id: json["id"] as int,
          content: json["content"] as String);
}