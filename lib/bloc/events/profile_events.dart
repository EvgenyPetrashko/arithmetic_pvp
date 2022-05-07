abstract class ProfileEvent {}

class ProfileEventUserLoad extends ProfileEvent {}

class ProfileEventChangeUsername extends ProfileEvent {
  final String newUsername;

  ProfileEventChangeUsername(this.newUsername);
}

class ProfileEventBalanceUpdate extends ProfileEvent {}

class ProfileEventChangeThemeMode extends ProfileEvent {
  final bool isDark;

  ProfileEventChangeThemeMode(this.isDark);
}
