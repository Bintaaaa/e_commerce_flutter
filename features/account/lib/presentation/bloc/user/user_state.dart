part of 'user_cubit.dart';

class UserState extends Equatable {
  final ViewData<UserEntity> userState;
  const UserState({
    required this.userState,
  });

  UserState copyWith({required ViewData<UserEntity>? userState}) {
    return UserState(
      userState: userState ?? this.userState,
    );
  }

  @override
  List<Object?> get props => [userState];
}
