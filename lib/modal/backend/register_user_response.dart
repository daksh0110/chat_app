class RegisterUserData {
  final String? accessToken;
  final String? refreshToken;
  final String? deviceId;

  RegisterUserData({this.accessToken, this.refreshToken, this.deviceId});

  factory RegisterUserData.fromJson(Map<String, dynamic> json) {
    return RegisterUserData(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      deviceId: json['deviceId'],
    );
  }
}
