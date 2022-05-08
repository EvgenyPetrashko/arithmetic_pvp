class TaskReport {
  final int id;
  final bool isCorrect;

  TaskReport({required this.id, required this.isCorrect});

  factory TaskReport.fromJson(Map<String, dynamic> json) =>
      TaskReport(id: json["task_id"] as int, isCorrect: json["result"] as bool);
}
