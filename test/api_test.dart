import 'package:arithmetic_pvp/data/api.dart';
import 'package:arithmetic_pvp/data/auth_interceptor.dart';
import 'package:arithmetic_pvp/data/models/balance_response.dart';
import 'package:arithmetic_pvp/data/models/buy_response.dart';
import 'package:arithmetic_pvp/data/models/join_room_response.dart';
import 'package:arithmetic_pvp/data/models/overall_stats.dart';
import 'package:arithmetic_pvp/data/models/profile.dart';
import 'package:arithmetic_pvp/data/models/select_response.dart';
import 'package:arithmetic_pvp/data/network_client.dart';
import 'package:arithmetic_pvp/data/storage.dart';
import 'package:flutter_test/flutter_test.dart';


void main(){
  late Api api;
  setUp(() async {
    final headers = {
      "Test-Name": "testUserName",
      "Test-Email": "testUserEmail",
    };
    Storage storage = Storage();
    AuthInterceptor interceptor = AuthInterceptor(await storage.init());
    NetworkClient client = NetworkClient(interceptor);
    api = Api(client);
    api.client.api.options.headers = headers;
  });

  test("Test getProfileInfo", () async {
    Profile? profile = await api.getProfileInfo();
    expect(profile != null, true);
  });

  test("Test buySkin", () async {
    BuyResponse buyResponse = await api.buySkin(11);
    expect(buyResponse.isSuccess, false);
  });

  test("Test selectSkin", () async {
    SelectResponse selectResponse = await api.selectSkin(3);
    expect(selectResponse.isSuccess, false);
  });

  test("Test getBalances", () async {
    Balance? balance = await api.getBalances();
    expect(balance != null, true);
    expect(balance?.gold, 0);
  });

  test("Test creation and getting this room", () async {
    JoinRoomResponse? joinRoomResponse = await api.createRoom();
    expect(joinRoomResponse != null, true);
    final roomId = joinRoomResponse?.id;
    Future.delayed(const Duration(seconds: 3));
    List<JoinRoomResponse>? rooms = await api.getOpenRooms();
    List<int>? roomIds = rooms?.map((e) => e.id).toList();
    expect(rooms != null, true);
    expect(roomIds?.contains(roomId), true);
  });

  test("Test getOverallStats", () async {
    OverallStats? overallStats = await api.getOverallStats();
    expect(overallStats != null, true);
  });


}