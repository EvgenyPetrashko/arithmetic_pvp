abstract class MainState {}

class MainStateLoading extends MainState {}

class MainStateLoaded extends MainState {
  final bool isLoginnedIn;

  MainStateLoaded(this.isLoginnedIn);
}
