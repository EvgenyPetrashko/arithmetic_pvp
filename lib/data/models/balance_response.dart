
class Balance{
  final int gold;
  Balance({required this.gold});

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
    gold: json['gold'] as int,
  );


}