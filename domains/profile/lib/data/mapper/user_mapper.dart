import 'package:profile/data/model/response/user_response_dto.dart';
import 'package:profile/domain/entity/response/user_entity_response.dart';

class ProfileMapper {
  UserEntity mapUserDtoToEntity(UserDataDTO userDataDTO) => UserEntity(
        id: userDataDTO.id ?? '',
        username: userDataDTO.username ?? '',
        role: userDataDTO.role ?? '',
        imageUrl: userDataDTO.imageUrl ?? '',
        fullName: userDataDTO.fullName ?? '',
        city: userDataDTO.city ?? '',
        simpleAddress: userDataDTO.simpleAddress ?? '',
      );
}
