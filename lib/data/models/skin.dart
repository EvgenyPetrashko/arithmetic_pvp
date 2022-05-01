import 'package:json_annotation/json_annotation.dart';

part 'skin.g.dart';

@JsonSerializable()
class Skin {
  int id;
  String name;
  String description;
  int cost;
  @JsonKey(name: "asset_url")
  String assetUrl;
  @JsonKey(name: "is_owner")
  bool isOwner;

  Skin(
      {required this.id,
      required this.name,
      required this.description,
      required this.cost,
      required this.assetUrl,
      required this.isOwner});

  factory Skin.fromJson(Map<String, dynamic> json) => _$SkinFromJson(json);

  Map<String, dynamic> toJson() => _$SkinToJson(this);
}
