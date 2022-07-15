import 'package:auth/presentation/bloc/sign_up/sign_up_event.dart';
import 'package:authentication/domain/usecases/sign_up_usecase.dart';
import 'package:common/utils/constants/app_constants.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/bloc/bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;

  SignUpBloc({
    required this.signUpUseCase,
  }) : super(
          SignUpState(
            signUpState: ViewData.initial(),
          ),
        ) {
    on<UsernameChange>((event, emit) {
      if (event.username.isEmpty) {
        emit(
          SignUpState(
            signUpState: ViewData.error(
              message: AppConstants.errorKey.username,
              failure: FailureResponse(
                errorMessage: AppConstants.errorMessage.usernameEmpty,
              ),
            ),
          ),
        );
      } else {
        emit(
          SignUpState(
            signUpState: ViewData.initial(),
          ),
        );
      }
    });
    on<PasswordChange>((event, emit) {
      if (event.password.isEmpty) {
        emit(
          SignUpState(
            signUpState: ViewData.error(
              message: AppConstants.errorKey.password,
              failure: FailureResponse(
                errorMessage: AppConstants.errorMessage.passwordEmpty,
              ),
            ),
          ),
        );
      } else {
        emit(
          SignUpState(
            signUpState: ViewData.initial(),
          ),
        );
      }
    });

    on<ConfirmPassword>((event, emit) {
      if (event.confirmPassword.isEmpty) {
        emit(
          SignUpState(
            signUpState: ViewData.error(
              message: AppConstants.errorKey.confirmPassword,
              failure: FailureResponse(
                errorMessage: AppConstants.errorMessage.confirmPasswordEmpty,
              ),
            ),
          ),
        );
      } else if (event.confirmPassword != event.password) {
        emit(
          SignUpState(
            signUpState: ViewData.error(
              message: AppConstants.errorKey.confirmPassword,
              failure: FailureResponse(
                errorMessage: AppConstants.errorMessage.confirmPasswordMustSame,
              ),
            ),
          ),
        );
      } else {
        emit(
          SignUpState(
            signUpState: ViewData.initial(),
          ),
        );
      }
    });

    on<SignUp>(
      (event, emit) async {
        emit(
          SignUpState(
            signUpState: ViewData.loading(),
          ),
        );
        if (event.authRequestEntity.password.isNotEmpty &&
            event.authRequestEntity.username.isNotEmpty) {
          final result = await signUpUseCase.call(event.authRequestEntity);
          result.fold(
            (failure) => emit(
              SignUpState(
                signUpState: ViewData.error(
                  message: failure.errorMessage,
                  failure: failure,
                ),
              ),
            ),
            (result) => emit(
              SignUpState(
                signUpState: ViewData.loaded(),
              ),
            ),
          );
        } else {
          emit(
            SignUpState(
              signUpState: ViewData.error(
                message: AppConstants.errorMessage.formNotEmpty,
                failure: FailureResponse(
                  errorMessage: AppConstants.errorMessage.formNotEmpty,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
