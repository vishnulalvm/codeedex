class LoginRequest {
  final String emailPhone;
  final String password;

  LoginRequest({
    required this.emailPhone,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email_phone': emailPhone,
      'password': password,
    };
  }
}
