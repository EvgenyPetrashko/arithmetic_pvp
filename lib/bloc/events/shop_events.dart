import 'package:arithmetic_pvp/data/models/skin.dart';

abstract class ShopUserEvent {}

class ShopUserEventSkinsLoading extends ShopUserEvent {}

class ShopUserEventBuySkin extends ShopUserEvent{
  final Skin skin;
  ShopUserEventBuySkin(this.skin);
}

class ShopUserEventSelectSkin extends ShopUserEvent{
  final Skin skin;
  ShopUserEventSelectSkin(this.skin);
}