class AuthResponseDto {
  final bool? status;
  final int? code;
  final String? message;
  final AuthReponse? data;

  AuthResponseDto({this.status, this.code, this.message, this.data});

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) =>
      AuthResponseDto(
        status: json['status'],
        code: json['code'],
        message: json['message'],
        data: AuthReponse.fromJson(json['data']),
      );
}

class AuthReponse {
  final String? token;
  AuthReponse({this.token});

  factory AuthReponse.fromJson(Map<String, dynamic> json) => AuthReponse(
        token: json['token'],
      );
}
