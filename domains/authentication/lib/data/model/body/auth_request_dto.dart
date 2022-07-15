class AuthRequestDto {
  final String username;
  final String password;
  AuthRequestDto({required this.username, required this.password});

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
