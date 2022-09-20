import 'package:authentication/domain/entity/body/auth_request_entity.dart';
import 'package:authentication/domain/entity/response/auth_response_entity.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:dependencies/dartz/dartz.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  Future<Either<FailureResponse, bool>> cacheOnBoarding();

  Future<Either<FailureResponse, bool>> getOnBoardingStatus();

  Future<Either<FailureResponse, AuthResponseEntity>> sighnIn(
      {required AuthRequestEntity authRequestEntity});

  Future<Either<FailureResponse, AuthResponseEntity>> sighnUp(
      {required AuthRequestEntity authRequestEntity});

  Future<Either<FailureResponse, bool>> cacheToken({required String token});

  Future<Either<FailureResponse, String>> getToken();
  Future<Either<FailureResponse, bool>> removeUserData();
}
