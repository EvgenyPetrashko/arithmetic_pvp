abstract class MainState { }

class MainStateLoading extends MainState { }

class MainStateLoaded extends MainState {
  final String? cookie;
  MainStateLoaded(this.cookie);
}