abstract class ProfileEvent {}

class ProfileEventUserLoad extends ProfileEvent {}

class ProfileEventCheckUsername extends ProfileEvent {
  String newUsername;

  ProfileEventCheckUsername(this.newUsername);
}

class ProfileEventChangeUsername extends ProfileEvent {
  String newUsername;

  ProfileEventChangeUsername(this.newUsername);
}
