import 'package:authentication/domain/entity/body/auth_request_entity.dart';
import 'package:authentication/domain/usecases/sign_in_usecase.dart';
import 'package:authentication/domain/usecases/cache_token_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:common/utils/constants/app_constants.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:dependencies/equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase signInUseCase;
  final CacheTokenUseCase cacheTokenUseCase;
  SignInBloc({
    required this.signInUseCase,
    required this.cacheTokenUseCase,
  }) : super(SignInState(signInState: ViewData.initial())) {
    on<UsernameChange>(
      (event, emit) => {
        if (event.username.isEmpty)
          {
            emit(
              SignInState(
                signInState: ViewData.error(
                  message: AppConstants.errorMessage.usernameEmpty,
                  failure: FailureResponse(
                    errorMessage: AppConstants.errorMessage.usernameEmpty,
                  ),
                ),
              ),
            )
          },
      },
    );
    on<PasswordChange>(
      (event, emit) => {
        if (event.password.isEmpty)
          {
            emit(
              SignInState(
                signInState: ViewData.error(
                  message: AppConstants.errorMessage.passwordEmpty,
                  failure: FailureResponse(
                    errorMessage: AppConstants.errorMessage.passwordEmpty,
                  ),
                ),
              ),
            ),
          }
      },
    );
    on<SignIn>(
      (event, emit) async {
        emit(
          SignInState(
            signInState: ViewData.loading(),
          ),
        );
        if (event.authRequestEntity.username.isNotEmpty &&
            event.authRequestEntity.password.isNotEmpty) {
          final result = await signInUseCase.call(
            event.authRequestEntity,
          );

          result.fold(
              (failure) => emit(
                    SignInState(
                      signInState: ViewData.error(
                          message: AppConstants.errorMessage.formNotEmpty,
                          failure: failure),
                    ),
                  ),
              (data) async => await cacheTokenUseCase.call(
                    data.token,
                  ));
        } else {
          SignInState(
            signInState: ViewData.error(
              message: AppConstants.errorMessage.formNotEmpty,
              failure: FailureResponse(
                errorMessage: AppConstants.errorMessage.formNotEmpty,
              ),
            ),
          );
        }
      },
    );
  }
}
