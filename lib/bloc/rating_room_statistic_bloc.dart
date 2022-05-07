import 'package:arithmetic_pvp/bloc/events/rating_room_statistic_events.dart';
import 'package:arithmetic_pvp/bloc/states/rating_room_statistic_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RatingRoomStatisticBloc extends Bloc<RatingRoomStatisticEvent,
      RatingRoomStatisticState>{

  RatingRoomStatisticBloc(): super(RatingRoomStatisticStateInitial()) {

  }
}