import '../../data/models/balance_response.dart';

abstract class BalanceState {}

class BalanceLoadingState extends BalanceState {}

class BalanceLoadedState extends BalanceState {
  final Balance balance;

  BalanceLoadedState(this.balance);
}

class BalanceErrorState extends BalanceState {}
