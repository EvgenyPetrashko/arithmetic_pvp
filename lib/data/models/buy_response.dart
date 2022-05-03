class BuyResponse{
  bool isSuccess;
  String report;
  BuyResponse({required this.isSuccess, required this.report});

  factory BuyResponse.fromJson(Map<String, dynamic> json) => BuyResponse(
    isSuccess: json['status'] as bool,
    report: json['report'] as String,
  );
}