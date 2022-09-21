part of 'logout_cubit.dart';

class LogoutState extends Equatable {
  final ViewData<bool> logoutState;
  const LogoutState({
    required this.logoutState,
  });

  LogoutState copyWith({ViewData<bool>? logoutState}) => LogoutState(
        logoutState: logoutState ?? this.logoutState,
      );

  @override
  List<Object?> get props => [logoutState];
}
