part of 'sign_in_bloc.dart';

@immutable
class SignInState extends Equatable {
  final ViewData signInState;

  const SignInState({
    required this.signInState,
  });

  SignInState copyWith({ViewData? signInState}) {
    return SignInState(
      signInState: signInState ?? this.signInState,
    );
  }

  @override
  List<Object?> get props => [signInState];
}
