import 'package:arithmetic_pvp/data/models/change_name_response.dart';

import '../../data/models/user.dart';
import '../../data/models/balance_response.dart';

abstract class ProfileState {}

abstract class ProfilePageState extends ProfileState {}

class ProfileStateInitial extends ProfilePageState {}

class ProfileStateLoading extends ProfilePageState {}

class ProfileStateLoaded extends ProfilePageState {
  final Profile? profile;

  ProfileStateLoaded(this.profile);
}

class ProfileStateError extends ProfileState {
  String error;

  ProfileStateError(this.error);
}

abstract class ProfileChangeUsernameState extends ProfileState {}

class ProfileChangeUsernameStateInitial extends ProfileChangeUsernameState {}

class ProfileChangeUsernameStateLoading extends ProfileChangeUsernameState {}

class ProfileChangeUsernameStateLoaded extends ProfileChangeUsernameState {
  final ChangeNameResponse changeNameResponse;

  ProfileChangeUsernameStateLoaded(this.changeNameResponse);
}

abstract class ProfileBalanceState extends ProfileState {}

class ProfileBalanceStateLoading extends ProfileBalanceState {}

class ProfileBalanceStateLoaded extends ProfileBalanceState {
  final Balance balance;

  ProfileBalanceStateLoaded(this.balance);
}

class ProfileBalanceStateError extends ProfileBalanceState {}

class ProfileThemeState extends ProfileState {}

class ProfileThemeChanged extends ProfileThemeState {
  final bool isDark;

  ProfileThemeChanged(this.isDark);
}
