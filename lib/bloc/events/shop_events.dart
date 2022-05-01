import 'package:arithmetic_pvp/data/models/skin.dart';

abstract class ShopUserEvent {}

class ShopUserEventLoading extends ShopUserEvent {}

class ShopUserEventBuy extends ShopUserEvent{
  final Skin skin;
  ShopUserEventBuy(this.skin);
}