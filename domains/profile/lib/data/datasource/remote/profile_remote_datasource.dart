import 'package:common/utils/constants/app_constants.dart';
import 'package:dependencies/dio/dio.dart';
import 'package:profile/data/model/response/user_response_dto.dart';

abstract class ProfileRemoteDatasourece {
  const ProfileRemoteDatasourece();

  Future<UserResponseDto> getUser();
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasourece {
  final Dio dio;
  ProfileRemoteDatasourceImpl({
    required this.dio,
  });

  @override
  Future<UserResponseDto> getUser() async {
    try {
      final response = await dio.get(AppConstants.appApi.user);
      return UserResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
