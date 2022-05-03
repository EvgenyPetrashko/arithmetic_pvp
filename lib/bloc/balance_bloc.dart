

import 'package:arithmetic_pvp/bloc/events/balance_events.dart';
import 'package:arithmetic_pvp/bloc/states/balance_states.dart';
import 'package:arithmetic_pvp/data/storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/api.dart';
import '../data/models/balance_response.dart';
import '../data/models/user.dart';

class BalanceBloc extends Bloc<BalanceUserEvent, BalanceState>{
  BalanceBloc() : super(BalanceLoadingState()){
    final Api _api = GetIt.instance<Api>();
    final Storage _storage = GetIt.instance<Storage>();

   on<BalanceUserEventUpdate>((event, emit) async {
     emit(BalanceLoadingState());
     Balance? balance = await _api.getBalances();
     if (balance != null){
       Profile? profile = _storage.getProfile("user");
       if (profile != null){
         profile.gold = balance.gold;
         _storage.setProfile("user", profile);
       }
       emit(BalanceLoadedState(balance));
     }else{
       emit(BalanceErrorState());
     }
   });
  }
}