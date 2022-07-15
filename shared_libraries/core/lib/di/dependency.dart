import 'package:common/utils/constants/app_constants.dart';
import 'package:core/network/dio_handler.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:dependencies/get_it/get_it.dart';

class RegisterCoreModule {
  RegisterCoreModule() {
    _registerCore();
  }

  void _registerCore() {
    sl.registerLazySingleton<Dio>(() => sl<DioHandler>().dio);
    sl.registerLazySingleton<DioHandler>(() => DioHandler(
          sharedPreferences: sl(),
          apiBaseUrl: AppConstants.appApi.baseUrl,
        ));
  }
}
