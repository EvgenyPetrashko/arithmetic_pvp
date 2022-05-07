import 'package:arithmetic_pvp/bloc/states/waiting_room_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import '../data/api.dart';
// import '../data/models/user.dart';
import 'events/waiting_room_events.dart';

class WaitingRoomBloc extends Bloc<WaitingRoomEvent, WaitingRoomState> {

  WaitingRoomBloc() : super(UsersStateLoading()) {
    // final Api _api = GetIt.instance<Api>();

    // on<EventUsersLoading>(
    //   (event, emit) async {
    //     final List<Profile> users = await _api.getUsers();
    //     if (users.isEmpty) {
    //       emit(UsersStateError("No users to display"));
    //     } else {
    //       emit(UsersStateLoaded(users));
    //     }
    //   },
    // );

  }
}
