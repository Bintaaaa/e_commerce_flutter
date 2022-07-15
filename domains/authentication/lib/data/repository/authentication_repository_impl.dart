import 'package:authentication/data/datasource/local/authentication_local_datasource.dart';
import 'package:authentication/data/datasource/remote/authentication_remote_datasource.dart';
import 'package:authentication/data/mapper/authentication_mapper.dart';
import 'package:authentication/domain/entity/response/auth_response_entity.dart';
import 'package:authentication/domain/entity/body/auth_request_entity.dart';
import 'package:authentication/domain/repository/authentication_repository.dart';
import 'package:common/utils/constants/app_constants.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dependencies/dio/dio.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationLocalDataSources authenticationLocalDataSources;
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;
  final AuthenticationMapper authenticationMapper;
  AuthenticationRepositoryImpl({
    required this.authenticationLocalDataSources,
    required this.authenticationRemoteDataSource,
    required this.authenticationMapper,
  });

  @override
  Future<Either<FailureResponse, bool>> cacheOnBoarding() async {
    try {
      await authenticationLocalDataSources.cacheOnBoarding();
      return const Right(true);
    } on Exception catch (error) {
      return Left(FailureResponse(errorMessage: error.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, bool>> getOnBoardingStatus() async {
    try {
      final response =
          await authenticationLocalDataSources.getOnBoardingStatus();
      return Right(response);
    } on Exception catch (error) {
      return Left(FailureResponse(errorMessage: error.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, AuthResponseEntity>> sighnIn(
      {required AuthRequestEntity authRequestEntity}) async {
    try {
      final response = await authenticationRemoteDataSource.signIn(
        authRequestDto: authenticationMapper
            .mapAuthRequestEntityToAuthRequestDto(authRequestEntity),
      );
      return Right(
        authenticationMapper.mapAuthResponseDtoToAuthResponseEntity(response),
      );
    } on DioError catch (e) {
      return Left(
        FailureResponse(
          errorMessage:
              e.response?.data[AppConstants.errorKey.message.toString()],
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, AuthResponseEntity>> sighnUp(
      {required AuthRequestEntity authRequestEntity}) async {
    try {
      final response = await authenticationRemoteDataSource.signUp(
        authRequestDto: authenticationMapper
            .mapAuthRequestEntityToAuthRequestDto(authRequestEntity),
      );
      return Right(
        authenticationMapper.mapAuthResponseDtoToAuthResponseEntity(response),
      );
    } on DioError catch (e) {
      return Left(
        FailureResponse(
          errorMessage:
              e.response?.data[AppConstants.errorKey.message.toString()],
        ),
      );
    }
  }
}
