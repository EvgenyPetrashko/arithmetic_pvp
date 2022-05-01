import 'package:arithmetic_pvp/data/models/skin.dart';

abstract class ShopState {}

class ShopStateSkinsLoading extends ShopState {}

class ShopStateSkinsLoaded extends ShopState {
  List<Skin> skins;

  ShopStateSkinsLoaded(this.skins);
}

class ShopStateSkinsError extends ShopState {
  String error;

  ShopStateSkinsError(this.error);
}

class ShopStateBuyLoading extends ShopState {}

class ShopStateBuyLoaded extends ShopState {
  bool isSuccess;

  ShopStateBuyLoaded(this.isSuccess);
}

class ShopStateBuyError extends ShopState {
  String error;

  ShopStateBuyError(this.error);
}
