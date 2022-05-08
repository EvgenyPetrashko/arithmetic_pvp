import 'package:arithmetic_pvp/data/models/skin.dart';

abstract class SkinsEvent {}

class SkinsEventLoading extends SkinsEvent {}

class SkinsEventBuySkin extends SkinsEvent {
  final Skin skin;

  SkinsEventBuySkin(this.skin);
}

class SkinsEventSelectSkin extends SkinsEvent {
  final Skin skin;

  SkinsEventSelectSkin(this.skin);
}
