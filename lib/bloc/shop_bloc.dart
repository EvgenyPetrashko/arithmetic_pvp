import 'package:arithmetic_pvp/bloc/events/profile_events.dart';
import 'package:arithmetic_pvp/bloc/events/skin_events.dart';
import 'package:arithmetic_pvp/bloc/profile_bloc.dart';
import 'package:arithmetic_pvp/bloc/states/skin_states.dart';
import 'package:arithmetic_pvp/data/api.dart';
import 'package:arithmetic_pvp/data/models/buy_response.dart';
import 'package:arithmetic_pvp/data/models/select_response.dart';
import 'package:arithmetic_pvp/data/storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/models/skin.dart';
import '../data/models/profile.dart';

class ShopBloc extends Bloc<SkinsEvent, SkinState> {
  final ProfileBloc _profileBloc;

  ShopBloc(this._profileBloc) : super(SkinsStateShopLoading()) {
    final Api _api = GetIt.instance<Api>();
    final Storage _storage = GetIt.instance<Storage>();

    on<SkinsEventLoading>((event, emit) async {
      _profileBloc.add(ProfileEventBalanceUpdate());
      final List<Skin> skins = await _api.getSkins();
      if (skins.isEmpty) {
        emit(SkinsStateShopError("No skins to display"));
      } else {
        skins.sort((a, b) => (a.cost > b.cost) ? 1 : -1);
        emit(SkinsStateShopLoaded(skins));
      }
    });

    on<SkinsEventBuySkin>((event, emit) async {
      emit(SkinBuyStateLoading());
      final BuyResponse buyResponse = await _api.buySkin(event.skin.id);
      if (!buyResponse.isSuccess) {
        emit(SkinBuyStateError(buyResponse.report));
      } else {
        _profileBloc.add(ProfileEventUserLoad());
        emit(SkinBuyStateLoaded(event.skin));
      }
      _profileBloc.add(ProfileEventBalanceUpdate());
    });

    on<SkinsEventSelectSkin>((event, emit) async {
      emit(SkinSelectLoading());
      final SelectResponse selectResponse =
          await _api.selectSkin(event.skin.id);
      final isError = selectResponse.error;
      if (isError == null) {
        Profile? profile = _storage.getProfile("user");
        if (profile != null) {
          profile.assetUrl = event.skin.assetUrl;
          _storage.setProfile("user", profile);
        }
        emit(SkinSelectLoaded(event.skin, selectResponse.isSuccess));
      } else {
        emit(SkinSelectError(isError));
      }
    });
  }
}
