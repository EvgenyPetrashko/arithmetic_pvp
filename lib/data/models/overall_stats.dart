class OverallStats {
  final int matchesPlayed;
  final int tasksSolved;
  final int rating;
  final double timeSpent;
  final double avgTimePerTask;

  OverallStats(
      {required this.matchesPlayed,
      required this.tasksSolved,
      required this.rating,
      required this.timeSpent,
      required this.avgTimePerTask});

  factory OverallStats.fromJson(Map<String, dynamic> json) => OverallStats(
        matchesPlayed: json["matches_played"] as int,
        tasksSolved: json["tasks_solved"] as int,
        rating: json["rating"] as int,
        timeSpent: json["time_spent"] as double,
        avgTimePerTask: json["avg_time_per_task"] as double,
      );
}
