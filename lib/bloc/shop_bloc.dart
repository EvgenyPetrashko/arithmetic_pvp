import 'package:arithmetic_pvp/bloc/events/profile_events.dart';
import 'package:arithmetic_pvp/bloc/events/shop_events.dart';
import 'package:arithmetic_pvp/bloc/profile_bloc.dart';
import 'package:arithmetic_pvp/bloc/states/shop_states.dart';
import 'package:arithmetic_pvp/data/api.dart';
import 'package:arithmetic_pvp/data/models/buy_response.dart';
import 'package:arithmetic_pvp/data/models/select_response.dart';
import 'package:arithmetic_pvp/data/storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/models/skin.dart';
import '../data/models/user.dart';

class ShopBloc extends Bloc<ShopUserEvent, ShopState> {
  final ProfileBloc _profileBloc;

  ShopBloc(this._profileBloc) : super(ShopSkinsStateLoading()) {
    final Api _api = GetIt.instance<Api>();
    final Storage _storage = GetIt.instance<Storage>();

    on<ShopUserEventSkinsLoading>((event, emit) async {
      _profileBloc.add(ProfileEventBalanceUpdate());
      final List<Skin> skins = await _api.getSkins();
      if (skins.isEmpty) {
        emit(ShopSkinsStateError("No skins to display"));
      } else {
        skins.sort((a, b) => (a.cost > b.cost) ? 1 : -1);
        emit(ShopSkinsStateLoaded(skins));
      }
    });

    on<ShopUserEventBuySkin>((event, emit) async {
      emit(ShopBuyStateLoading());
      final BuyResponse buyResponse = await _api.buySkin(event.skin.id);
      if (!buyResponse.isSuccess) {
        emit(ShopBuyStateError(buyResponse.report));
      } else {
        _profileBloc.add(ProfileEventUserLoad());
        emit(ShopBuyStateLoaded(event.skin));
      }
      _profileBloc.add(ProfileEventBalanceUpdate());
    });

    on<ShopUserEventSelectSkin>((event, emit) async {
      emit(ShopSelectSkinLoading());
      final SelectResponse selectResponse =
          await _api.selectSkin(event.skin.id);
      final isError = selectResponse.error;
      if (isError == null){
        Profile? profile = _storage.getProfile("user");
        if (profile != null){
          profile.assetUrl = event.skin.assetUrl;
          _storage.setProfile("user", profile);
        }
        emit(ShopSelectSkinLoaded(event.skin, selectResponse.isSuccess));
      } else {
        emit(ShopSelectSkinError(isError));
      }
    });
  }
}
