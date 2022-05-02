class SelectResponse{
  bool isSuccess;
  String? error;
  SelectResponse(this.error, {required this.isSuccess});

  factory SelectResponse.fromJson(Map<String, dynamic> json) => SelectResponse(
    null,
    isSuccess: json['status'] as bool,
  );
}