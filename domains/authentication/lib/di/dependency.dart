import 'package:authentication/data/datasource/local/authentication_local_datasource.dart';
import 'package:authentication/data/mapper/authentication_mapper.dart';
import 'package:authentication/data/repository/authentication_repository_impl.dart';
import 'package:authentication/domain/repository/authentication_repository.dart';
import 'package:authentication/domain/usecases/cache_onboarding_usecase.dart';
import 'package:authentication/domain/usecases/cache_token_usecase.dart';
import 'package:authentication/domain/usecases/get_onboarding_status_usecase.dart';
import 'package:authentication/domain/usecases/get_token_usecase.dart';
import 'package:authentication/domain/usecases/sign_in_usecase.dart';
import 'package:authentication/domain/usecases/sign_up_usecase.dart';
import 'package:dependencies/get_it/get_it.dart';
import 'package:authentication/data/datasource/remote/authentication_remote_datasource.dart';

class AuthenticationDependency {
  AuthenticationDependency() {
    _registerDataSources();
    _registerRepository();
    _registerUseCases();
    _registerMapper();
  }

  void _registerDataSources() {
    sl.registerLazySingleton<AuthenticationLocalDataSources>(
      () => AuthenticationLocalDataSourcesImpl(
        sharedPreferences: sl(),
      ),
    );
    sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(
        dio: sl(),
      ),
    );
  }

  void _registerRepository() {
    sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(
        authenticationLocalDataSources: sl(),
        authenticationMapper: sl(),
        authenticationRemoteDataSource: sl(),
      ),
    );
  }

  void _registerMapper() {
    sl.registerLazySingleton<AuthenticationMapper>(
      () => AuthenticationMapper(),
    );
  }

  void _registerUseCases() {
    sl.registerLazySingleton<GetOnBoardingStatusUseCase>(
      () => GetOnBoardingStatusUseCase(
        authenticationRepository: sl(),
      ),
    );
    sl.registerLazySingleton<CacheOnBoardingUseCase>(
      () => CacheOnBoardingUseCase(
        authenticationRepository: sl(),
      ),
    );
    sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(
        authenticationRepository: sl(),
      ),
    );
    sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(
        authenticationRepository: sl(),
      ),
    );
    sl.registerLazySingleton<CacheTokenUseCase>(
      () => CacheTokenUseCase(
        authenticationRepository: sl(),
      ),
    );
    sl.registerLazySingleton<GetTokenUsecase>(
      () => GetTokenUsecase(
        authenticationRepository: sl(),
      ),
    );
  }
}
