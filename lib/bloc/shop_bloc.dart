import 'package:arithmetic_pvp/bloc/events/shop_events.dart';
import 'package:arithmetic_pvp/bloc/states/shop_states.dart';
import 'package:arithmetic_pvp/data/api.dart';
import 'package:arithmetic_pvp/data/models/buy_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/models/skin.dart';

class ShopBloc extends Bloc<ShopUserEvent, ShopState> {
  ShopBloc() : super(ShopStateSkinsLoading()) {
    final Api _api = GetIt.instance<Api>();

    on<ShopUserEventLoading>((event, emit) async {
      final List<Skin> skins = await _api.getSkins();
      if (skins.isEmpty) {
        emit(ShopStateSkinsError("No skins to display"));
      } else {
        skins.sort((a, b) => (a.cost > b.cost) ? 1 : -1);
        emit(ShopStateSkinsLoaded(
            skins));
      }
    });

    on<ShopUserEventBuy>((event, emit) async {
      final BuyResponse buyResponse = await _api.buySkin(event.skin.id);
      final String? displayedError = buyResponse.error;
      if (displayedError != null) {
        emit(ShopStateBuyError(displayedError));
      } else {
        emit(ShopStateBuyLoaded(buyResponse.isSuccess));
      }
    });
  }
}
