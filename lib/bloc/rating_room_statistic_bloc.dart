import 'dart:developer';

import 'package:arithmetic_pvp/bloc/events/rating_room_statistic_events.dart';
import 'package:arithmetic_pvp/bloc/states/rating_room_statistic_states.dart';
import 'package:arithmetic_pvp/data/models/player.dart';
import 'package:arithmetic_pvp/data/models/rating_room_stats.dart';
import 'package:arithmetic_pvp/data/models/rating_room_stats_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/storage.dart';
import '../data/web_socket_provider.dart';

class RatingRoomStatisticBloc
    extends Bloc<RatingRoomStatisticEvent, RatingRoomStatisticState> {
  late final WebSocketProvider webSocketProvider;

  RatingRoomStatisticBloc(List<Player> players)
      : super(RatingRoomStatisticStateInitial()) {
    final storage = GetIt.instance<Storage>();
    final profile = storage.getProfile('user');
    final int gold = profile?.gold ?? 0;
    final int rating = profile?.rating ?? 500;
    webSocketProvider = GetIt.instance<WebSocketProvider>();

    webSocketProvider.webSocketStream.listen((event) {
      if (event is RatingRoomStatisticEvent) {
        add(event);
      }
    });

    on<RatingRoomStatisticEventGetStats>((event, emit) {
      webSocketProvider.getStats();
    });

    on<RatingRoomStatisticEventReceived>((event, emit) {
      final RatingRoomStatsResponse stats = event.stats;
      final List<String> leaderboard = getLeaderboard(stats.leaderboard, players);
      final profile = storage.getProfile('user');
      if (profile != null) {
        profile.gold = stats.gold;
        profile.rating = stats.rating;
        storage.setProfile('user', profile);
      }

      emit(RatingRoomStatisticStateReceived(RatingRoomStats(
          stats.rating - rating, stats.gold - gold, leaderboard)));
    });

    on<RatingRoomStatisticEventUpdateLeaderBoard>((event, emit) {
      final List<String> leaderboard = getLeaderboard(event.leaderboard, players);
      emit(RatingRoomStatisticStateUpdateLeaderboard(leaderboard));
    });
  }

  List<String> getLeaderboard(List<int> leaderboardIds, List<Player> players) {
    final a1 = leaderboardIds
        .map((playerId) =>
        players.firstWhere((player) => player.playerId == playerId)).toList();
    final a2 = a1.map((player) => player.username).toList();

    final leaderboardNicks = a2;

    for (int i = 0; i < 3; i++) {
      if (i >= leaderboardNicks.length) {
        leaderboardNicks.add('-');
      }
    }
    if (leaderboardNicks.length == 4) {
      leaderboardNicks.removeLast();
    }
    return leaderboardNicks;
  }
}
