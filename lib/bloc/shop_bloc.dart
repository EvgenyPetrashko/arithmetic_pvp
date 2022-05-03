import 'package:arithmetic_pvp/bloc/balance_bloc.dart';
import 'package:arithmetic_pvp/bloc/events/balance_events.dart';
import 'package:arithmetic_pvp/bloc/events/shop_events.dart';
import 'package:arithmetic_pvp/bloc/states/shop_states.dart';
import 'package:arithmetic_pvp/data/api.dart';
import 'package:arithmetic_pvp/data/models/buy_response.dart';
import 'package:arithmetic_pvp/data/models/select_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/models/skin.dart';

class ShopBloc extends Bloc<ShopUserEvent, ShopState> {
  final BalanceBloc _balanceBloc;

  ShopBloc(this._balanceBloc) : super(ShopSkinsStateLoading()) {
    final Api _api = GetIt.instance<Api>();

    on<ShopUserEventSkinsLoading>((event, emit) async {
      _balanceBloc.add(BalanceUserEventUpdate());
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
        emit(ShopBuyStateLoaded(event.skin));
      }
      _balanceBloc.add(BalanceUserEventUpdate());
    });

    on<ShopUserEventSelectSkin>((event, emit) async {
      emit(ShopSelectSkinLoading());
      final SelectResponse selectResponse =
          await _api.selectSkin(event.skin.id);
      final isError = selectResponse.error;
      if (isError == null) {
        emit(ShopSelectSkinLoaded(event.skin, selectResponse.isSuccess));
      } else {
        emit(ShopSelectSkinError(isError));
      }
    });
  }
}
