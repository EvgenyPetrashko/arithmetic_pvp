// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Skin _$SkinFromJson(Map<String, dynamic> json) => Skin(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      cost: json['cost'] as int,
      assetUrl: json['asset_url'] as String,
      isOwner: json['is_owner'] as bool,
    );

Map<String, dynamic> _$SkinToJson(Skin instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'cost': instance.cost,
      'asset_url': instance.assetUrl,
      'is_owner': instance.isOwner,
    };
