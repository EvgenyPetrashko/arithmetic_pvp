class ChangeNameResponse {
  bool status;
  String? error;

  ChangeNameResponse({required this.status, required this.error});

  factory ChangeNameResponse.fromJson(Map<String, dynamic> json) =>
      ChangeNameResponse(
        status: json['status'] as bool,
        error: json['error'] as String?,
      );
}
