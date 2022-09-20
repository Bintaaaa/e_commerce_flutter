import 'package:dependencies/get_it/get_it.dart';
import 'package:profile/data/datasource/remote/profile_remote_datasource.dart';
import 'package:profile/data/mapper/user_mapper.dart';
import 'package:profile/data/repository/profile_repository.dart';
import 'package:profile/domain/repository/profile_repository.dart';
import 'package:profile/domain/usecase/get_user_usecase.dart';

class ProfileDepedency {
  ProfileDepedency() {
    _registerDatasource();
    _registerMapper();
    _registerRepository();
    _registerUsecase();
  }

  _registerDatasource() => sl.registerLazySingleton<ProfileRemoteDatasourece>(
        () => ProfileRemoteDatasourceImpl(
          dio: sl(),
        ),
      );

  _registerMapper() => sl.registerLazySingleton<ProfileMapper>(
        () => ProfileMapper(),
      );

  _registerRepository() => sl.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(
          profileRemoteDatasourece: sl(),
          profileMapper: sl(),
        ),
      );

  _registerUsecase() => sl.registerLazySingleton<GetUserUsecase>(
        () => GetUserUsecase(
          profileRepository: sl(),
        ),
      );
}
