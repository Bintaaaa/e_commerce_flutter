import 'package:common/utils/state/view_data_state.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:dependencies/equatable/equatable.dart';
import 'package:profile/domain/entity/response/user_entity_response.dart';
import 'package:profile/domain/usecase/get_user_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUserUsecase getUserUsecase;
  UserCubit({
    required this.getUserUsecase,
  }) : super(
          UserState(
            userState: ViewData.initial(),
          ),
        );

  void getUSer() async {
    emit(
      UserState(
        userState: ViewData.loading(),
      ),
    );

    final result = await getUserUsecase.call(
      const NoParams(),
    );

    result.fold(
      (failure) => emit(
        UserState(
          userState:
              ViewData.error(message: failure.errorMessage, failure: failure),
        ),
      ),
      (data) => emit(
        UserState(
          userState: ViewData.loaded(
            data: data,
          ),
        ),
      ),
    );
  }
}
