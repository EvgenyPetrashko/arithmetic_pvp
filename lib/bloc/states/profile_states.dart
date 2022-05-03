import '../../data/models/user.dart';

abstract class ProfileState {}

class ProfileStateInitial extends ProfileState {}

class ProfileStateLoading extends ProfileState {}

class ProfileStateLoaded extends ProfileState {
  final Profile? profile;

  ProfileStateLoaded(this.profile);
}

class ProfileStateUsernameCheckLoading extends ProfileState {}

class ProfileStateUsernameCheckLoaded extends ProfileState {
  final bool? checkReport;

  ProfileStateUsernameCheckLoaded(this.checkReport);
}

class ProfileStateUsernameCheckError extends ProfileState {
  final String error;

  ProfileStateUsernameCheckError(this.error);
}

class ProfileStateError extends ProfileState {
  String error;

  ProfileStateError(this.error);
}
