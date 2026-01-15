class LoginResponse {
  final int success;
  final String message;
  final String? id;
  final String? token;
  final UserData? userData;

  LoginResponse({
    required this.success,
    required this.message,
    this.id,
    this.token,
    this.userData,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? 0,
      message: json['message'] ?? '',
      id: json['id'],
      token: json['token'],
      userData: json['user'] != null ? UserData.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'id': id,
      'token': token,
      'user': userData?.toJson(),
    };
  }

  bool get isSuccess => success == 1;
}

class UserData {
  final String? name;
  final String? email;
  final String? phone;
  final String? image;

  UserData({
    this.name,
    this.email,
    this.phone,
    this.image,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
    };
  }
}
