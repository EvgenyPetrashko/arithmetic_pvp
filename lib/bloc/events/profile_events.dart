abstract class ProfileEvent {}

class ProfileEventUserLoad extends ProfileEvent {}

class ProfileEventChangeUsername extends ProfileEvent {
  String newUsername;

  ProfileEventChangeUsername(this.newUsername);
}

class ProfileEventBalanceUpdate extends ProfileEvent {}
