class PlayerProgress {
  final int id;
  final int tasksSolved;

  PlayerProgress({required this.id, required this.tasksSolved});

  factory PlayerProgress.fromJson(Map<String, dynamic> json) => PlayerProgress(
      id: json["player_id"] as int, tasksSolved: json["tasks_solved"] as int);
}
