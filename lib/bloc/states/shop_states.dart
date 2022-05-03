import 'package:arithmetic_pvp/data/models/skin.dart';

abstract class ShopState {}

abstract class ShopSkinsState extends ShopState {}

class ShopSkinsStateLoading extends ShopSkinsState {}

class ShopSkinsStateLoaded extends ShopSkinsState {
  List<Skin> skins;

  ShopSkinsStateLoaded(this.skins);
}

class ShopSkinsStateError extends ShopSkinsState {
  String error;

  ShopSkinsStateError(this.error);
}

abstract class ShopBuySkinState extends ShopState {}

class ShopBuyStateLoading extends ShopBuySkinState {}

class ShopBuyStateLoaded extends ShopBuySkinState {
  final Skin skin;

  ShopBuyStateLoaded(this.skin);
}

class ShopBuyStateError extends ShopBuySkinState {
  String error;

  ShopBuyStateError(this.error);
}

abstract class ShopSelectSkinState extends ShopState {}

class ShopSelectSkinLoading extends ShopSelectSkinState {}

class ShopSelectSkinLoaded extends ShopSelectSkinState {
  final Skin skin;
  final bool isSuccess;

  ShopSelectSkinLoaded(this.skin, this.isSuccess);
}

class ShopSelectSkinError extends ShopSelectSkinState {
  String error;

  ShopSelectSkinError(this.error);
}
