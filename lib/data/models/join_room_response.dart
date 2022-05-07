class JoinGameResponse {
  final int id;
  final String startTime;
  final int durationSeconds;
  final int tasksNum;

  JoinGameResponse(
      {required this.id,
      required this.startTime,
      required this.durationSeconds,
      required this.tasksNum});

  factory JoinGameResponse.fromJson(Map<String, dynamic> json) =>
      JoinGameResponse(
          id: json["id"] as int,
          startTime: json["start_time"] as String,
          durationSeconds: json["duration_seconds"] as int,
          tasksNum: json["tasks_num"] as int);
}
