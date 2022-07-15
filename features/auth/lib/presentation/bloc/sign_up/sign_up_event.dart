import 'package:authentication/domain/entity/body/auth_request_entity.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/equatable/equatable.dart';

part 'sign_up_state.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class UsernameChange extends SignUpEvent {
  final String username;

  const UsernameChange({required this.username});

  @override
  List<Object?> get props => [username];
}

class PasswordChange extends SignUpEvent {
  final String password;

  const PasswordChange({required this.password});

  @override
  List<Object?> get props => [password];
}

class ConfirmPassword extends SignUpEvent {
  final String password;
  final String confirmPassword;

  const ConfirmPassword({
    required this.confirmPassword,
    required this.password,
  });

  @override
  List<Object?> get props => [confirmPassword, password];
}

class SignUp extends SignUpEvent {
  final AuthRequestEntity authRequestEntity;

  const SignUp({required this.authRequestEntity});

  @override
  List<Object?> get props => [authRequestEntity];
}
