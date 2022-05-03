class Skin {
  int id;
  String name;
  String description;
  int cost;
  String assetUrl;
  bool isOwner;
  bool isSelected;

  Skin(
      {required this.id,
      required this.name,
      required this.description,
      required this.cost,
      required this.assetUrl,
      required this.isOwner,
      required this.isSelected});

  factory Skin.fromJson(Map<String, dynamic> json) => Skin(
        id: json['id'] as int,
        name: json['name'] as String,
        description: json['description'] as String,
        cost: json['cost'] as int,
        assetUrl: json['asset_url'] as String,
        isOwner: json['is_owner'] as bool,
        isSelected: json['is_selected'] as bool,
      );
}
