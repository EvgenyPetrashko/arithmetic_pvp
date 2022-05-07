import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:arithmetic_pvp/bloc/events/waiting_room_events.dart';
import 'package:arithmetic_pvp/bloc/events/rating_room_game_events.dart';
import 'package:arithmetic_pvp/bloc/events/rating_room_statistic_events.dart';
import 'package:arithmetic_pvp/bloc/events/web_socket_events.dart';
import 'package:arithmetic_pvp/data/models/join_room_response.dart';
import 'package:arithmetic_pvp/data/models/player.dart';
import 'package:arithmetic_pvp/data/models/player_progress.dart';
import 'package:arithmetic_pvp/data/models/rating_room_stats_response.dart';
import 'package:arithmetic_pvp/data/models/task_report.dart';

import 'package:web_socket_channel/io.dart';

import 'models/task.dart';

class WebSocketProvider {
  late final IOWebSocketChannel webSocketChannel;

  final StreamController<WebSocketEvent> _webSocketStreamController =
      StreamController<WebSocketEvent>.broadcast();

  WebSocketProvider(roomId, headers, [test = false]) {
    final String _url =
        "wss://arithmetic-pvp-backend.herokuapp.com/ws/rating_room/$roomId/";
    final String _testUrl = "ws://192.168.31.124:8000/ws/rating_room/$roomId/";
    if (test) {
      webSocketChannel =
          IOWebSocketChannel.connect(Uri.parse(_testUrl), headers: headers);
    } else {
      webSocketChannel =
          IOWebSocketChannel.connect(Uri.parse(_url), headers: headers);
    }

    webSocketChannel.stream
        .handleError((onError) {
          log("Some error occurred! Close the socket");
          _closeSocket();
          throw Exception();
        })
        .map((response) => _processServerResponse(response))
        .forEach((element) {
          _webSocketStreamController.add(element);
        });
  }

  Stream<WebSocketEvent> get webSocketStream =>
      _webSocketStreamController.stream;

  _processServerResponse(response) {
    response = jsonDecode(response);
    log("Response from server ${response.toString()}");
    if (response.containsKey('action')) {
      switch (response['action']) {
        case 'player_joined':
          {
            final List<Player> playersWaiting = response['players_waiting']
                .map((user) => Player.fromJson(user))
                .toList()
                .cast<Player>();
            return WaitingRoomEventPlayerJoined(playersWaiting);
          }
        case 'all_players_joined':
          {
            final JoinGameResponse room = JoinGameResponse.fromJson(response['room']);
            return WaitingRoomEventAllPlayersJoined(room);
          }
        case 'task_solved':
          {
            final List<PlayerProgress> playerProgresses = response['progress']
                .map(
                    (playerProgress) => PlayerProgress.fromJson(playerProgress))
                .toList()
                .cast<PlayerProgress>();
            return RatingRoomGameEventUpdateProgressbar(playerProgresses);
          }
        case 'refresh_stats':
          {
            final List<int> leaderboard = response['leaderboard'];
            return RatingRoomStatisticEventUpdateLeaderBoard(leaderboard);
          }
      }
    }
    if (response.containsKey('response_to')) {
      switch (response['response_to']) {
        case 'get_tasks':
          {
            final List<Task> tasks = response['tasks']
                .map((task) => Task.fromJson(task))
                .toList()
                .cast<Task>();
            return RatingRoomGameEventTasksReceived(tasks);
          }
        case 'submit':
          {
            final TaskReport taskReport = TaskReport.fromJson(response);
            log(taskReport.toString());
            return RatingRoomGameEventTaskReport(taskReport);
          }
        case 'get_stats':
          {
            final RatingRoomStatsResponse stats = RatingRoomStatsResponse.fromJson(response);
            return RatingRoomStatisticEventReceived(stats);
          }
      }
    }
    if (response.containsKey('error')) {
      log(response['error']);
      switch (response['error']) {
        case "The game didn't start yet":
          {
            return RatingRoomGameEventDidNotStart();
          }
        case "time is up":
          {
            return RatingRoomGameEventShowStatistic();
          }
        case "All tasks solved":
          {
            return RatingRoomGameEventShowStatistic();
          }
      }
    }
  }

  getTasks() {
    webSocketChannel.sink.add(jsonEncode({'action': 'get_tasks'}));
  }

  submitAnswer(answer) {
    webSocketChannel.sink.add(jsonEncode({'action': 'submit', 'answer': answer}));
  }

  getStats() {
    webSocketChannel.sink.add(jsonEncode({'action': 'get_stats'}));
  }

  _closeSocket() {
    webSocketChannel.sink.close();
  }
}
