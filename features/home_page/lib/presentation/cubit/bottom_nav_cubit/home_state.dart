part of 'home_cubit.dart';

class HomeState extends Equatable {
  final ViewData<int> homeState;

  const HomeState({
    required this.homeState,
  });

  HomeState copyWith({
    ViewData<int>? homeState,
  }) {
    return HomeState(
      homeState: homeState ?? this.homeState,
    );
  }

  @override
  List<Object?> get props => [homeState];
}
