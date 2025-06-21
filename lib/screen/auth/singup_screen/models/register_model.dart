class RegisterResponse {
  final bool status;
  final String message;
  final UserModel? data;

  RegisterResponse({required this.status, required this.message, this.data});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(status: json['status'] ?? false, message: json['message'] ?? '', data: json['data'] != null ? UserModel.fromJson(json['data']) : null);
  }

  Map<String, dynamic> toJson() => {'status': status, 'message': message, 'data': data?.toJson()};
}

class UserModel {
  final int userId;
  final String fullName;
  final String email;
  final String mobile;
  final String token;

  UserModel({required this.userId, required this.fullName, required this.email, required this.mobile, required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(userId: json['user_id'] ?? 0, fullName: json['full_name'] ?? '', email: json['email'] ?? '', mobile: json['mobile'] ?? '', token: json['token'] ?? '');
  }

  Map<String, dynamic> toJson() => {'user_id': userId, 'full_name': fullName, 'email': email, 'mobile': mobile, 'token': token};
}
