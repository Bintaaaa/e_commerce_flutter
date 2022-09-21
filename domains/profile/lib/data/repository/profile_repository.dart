import 'dart:io';

import 'package:common/utils/constants/app_constants.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:profile/data/datasource/remote/profile_remote_datasource.dart';
import 'package:profile/data/mapper/user_mapper.dart';
import 'package:profile/domain/entity/request/user_request_entity.dart';
import 'package:profile/domain/entity/response/user_entity_response.dart';
import 'package:dartz/dartz.dart';
import 'package:common/utils/error/failure_response.dart';
import 'package:profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasourece profileRemoteDatasourece;
  final ProfileMapper profileMapper;

  const ProfileRepositoryImpl({
    required this.profileRemoteDatasourece,
    required this.profileMapper,
  });

  @override
  Future<Either<FailureResponse, UserEntity>> getUser() async {
    try {
      final result = await profileRemoteDatasourece.getUser();
      return Right(
        profileMapper.mapUserDtoToEntity(result.data!),
      );
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage:
              error.response?.data[AppConstants.errorKey.message]?.toString() ??
                  error.response.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, UserEntity>> updateProfile(
      {required UserRequestEntity userRequestEntity}) async {
    try {
      final response = await profileRemoteDatasourece.updateProfile(
        userRequestDto: profileMapper.mapUserEntityToDto(
          userRequestEntity,
        ),
      );
      return Right(
        profileMapper.mapUserDtoToEntity(
          response.data!,
        ),
      );
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage:
              error.response?.data[AppConstants.errorKey.message]?.toString() ??
                  error.response.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, UserEntity>> uploadImage(
      {required File image}) async {
    try {
      final response = await profileRemoteDatasourece.uploadImage(
        image: image,
      );
      return Right(
        profileMapper.mapUserDtoToEntity(
          response.data!,
        ),
      );
    } on DioError catch (error) {
      return Left(
        FailureResponse(
          errorMessage:
              error.response?.data[AppConstants.errorKey.message]?.toString() ??
                  error.response.toString(),
        ),
      );
    }
  }
}
