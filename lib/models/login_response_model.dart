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
    // Check if customerdata exists and extract id and token from it
    final customerData = json['customerdata'];

    return LoginResponse(
      success: json['success'] ?? 0,
      message: json['message'] ?? '',
      id: customerData != null ? customerData['id'] : json['id'],
      token: customerData != null ? customerData['token'] : json['token'],
      userData: customerData != null ? UserData.fromJson(customerData) :
                (json['user'] != null ? UserData.fromJson(json['user']) : null),
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
  final String? id;
  final String? name;
  final String? email;
  final String? mobile;
  final String? referee;
  final String? referralCode;
  final int? status;
  final String? token;
  final int? otpVerificationStatus;
  final int? emailVerificationStatus;

  UserData({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.referee,
    this.referralCode,
    this.status,
    this.token,
    this.otpVerificationStatus,
    this.emailVerificationStatus,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'] ?? json['phone'],
      referee: json['referee'],
      referralCode: json['referral_code'],
      status: json['status'],
      token: json['token'],
      otpVerificationStatus: json['otpverificationstatus'],
      emailVerificationStatus: json['emailverificationstatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'referee': referee,
      'referral_code': referralCode,
      'status': status,
      'token': token,
      'otpverificationstatus': otpVerificationStatus,
      'emailverificationstatus': emailVerificationStatus,
    };
  }
}
