import 'package:authentication/domain/usecases/get_onboarding_status_usecase.dart';
import 'package:common/utils/constants/app_constants.dart';
import 'package:common/utils/state/view_data_state.dart';
import 'package:common/utils/use_case/use_case.dart';
import 'package:dependencies/bloc/bloc.dart';
import 'package:onboarding/presentation/bloc/splash_bloc/splash_state.dart';
import 'package:authentication/domain/usecases/get_token_usecase.dart';

class SplashCubit extends Cubit<SplashState> {
  final GetOnBoardingStatusUseCase getOnBoardingStatusUseCase;
  final GetTokenUsecase getTokenUsecase;

  SplashCubit({
    required this.getOnBoardingStatusUseCase,
    required this.getTokenUsecase,
  }) : super(SplashState(splashState: ViewData.initial()));

  void initSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    final onBoardingStatus =
        await getOnBoardingStatusUseCase.call(const NoParams());
    onBoardingStatus.fold(
      (failure) => emit(
        SplashState(
          splashState:
              ViewData.error(message: failure.errorMessage, failure: failure),
        ),
      ),
      (result) async {
        if (result) {
          final isTokenAvailable = await getTokenUsecase.call(
            const NoParams(),
          );
          isTokenAvailable.fold(
            (failure) => emit(
              SplashState(
                splashState: ViewData.error(
                    message: failure.errorMessage, failure: failure),
              ),
            ),
            (result) => {
              if (result.isEmpty)
                {
                  emit(
                    SplashState(
                      splashState: ViewData.loaded(
                        data: AppConstants.cachedKey.onBoardingKey,
                      ),
                    ),
                  )
                }
              else
                {
                  emit(
                    SplashState(
                      splashState: ViewData.loaded(
                        data: AppConstants.cachedKey.tokenKey,
                      ),
                    ),
                  )
                }
            },
          );
        } else {
          emit(
            SplashState(
              splashState: ViewData.noData(message: ""),
            ),
          );
        }
      },
    );
  }
}
