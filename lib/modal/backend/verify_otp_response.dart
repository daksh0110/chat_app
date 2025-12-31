class VerifyOtpData {
  final bool userExist;
  final String? accessToken;
  final String? refreshToken;
  final String? deviceId;

  VerifyOtpData({
    required this.userExist,
    this.accessToken,
    this.refreshToken,
    this.deviceId,
  });

  factory VerifyOtpData.fromJson(Map<String, dynamic> json) {
    return VerifyOtpData(
      userExist: json['userExist'] ?? false,
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      deviceId: json['deviceId'],
    );
  }
}
