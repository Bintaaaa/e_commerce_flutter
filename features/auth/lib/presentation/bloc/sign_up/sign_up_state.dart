part of 'sign_up_event.dart';

class SignUpState extends Equatable {
  final ViewData signUpState;

  const SignUpState({
    required this.signUpState,
  });

  SignUpState copyWith({
    ViewData? signUpState,
  }) {
    return SignUpState(
      signUpState: signUpState ?? this.signUpState,
    );
  }

  @override
  List<Object?> get props => [signUpState];
}
