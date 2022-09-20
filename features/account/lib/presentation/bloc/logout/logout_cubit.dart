import 'package:authentication/domain/usecases/post_logout_usecase.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/equatable/equatable.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final PostLogoutUsecase postLogoutUsecase;

  LogoutCubit({
    required this.postLogoutUsecase,
  }) : super(
          LogoutState(
            logoutState: ViewData.initial(),
          ),
        );

  void removeUser() async {
    emit(
      LogoutState(
        logoutState: ViewData.loading(),
      ),
    );
    final result = await postLogoutUsecase.call(
      const NoParams(),
    );
    result.fold(
      (failure) => emit(
        LogoutState(
          logoutState: ViewData.error(
            message: failure.errorMessage,
            failure: failure,
          ),
        ),
      ),
      (result) => emit(
        LogoutState(
          logoutState: ViewData.loaded(
            data: result,
          ),
        ),
      ),
    );
  }
}
