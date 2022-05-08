import 'package:arithmetic_pvp/data/models/skin.dart';

abstract class SkinState {}

abstract class SkinsShopState extends SkinState {}

class SkinsStateShopLoading extends SkinsShopState {}

class SkinsStateShopLoaded extends SkinsShopState {
  List<Skin> skins;

  SkinsStateShopLoaded(this.skins);
}

class SkinsStateShopError extends SkinsShopState {
  String error;

  SkinsStateShopError(this.error);
}

abstract class SkinBuyState extends SkinState {}

class SkinBuyStateLoading extends SkinBuyState {}

class SkinBuyStateLoaded extends SkinBuyState {
  final Skin skin;

  SkinBuyStateLoaded(this.skin);
}

class SkinBuyStateError extends SkinBuyState {
  String error;

  SkinBuyStateError(this.error);
}

abstract class SkinSelectState extends SkinState {}

class SkinSelectLoading extends SkinSelectState {}

class SkinSelectLoaded extends SkinSelectState {
  final Skin skin;
  final bool isSuccess;

  SkinSelectLoaded(this.skin, this.isSuccess);
}

class SkinSelectError extends SkinSelectState {
  String error;

  SkinSelectError(this.error);
}
