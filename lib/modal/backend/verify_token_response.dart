class VerifyTokenResponse {
  final String accessToken;
  final String refreshToken;
  final String deviceId;

  const VerifyTokenResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.deviceId,
  });

  factory VerifyTokenResponse.fromJson(Map<String, dynamic> json) {
    return VerifyTokenResponse(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      deviceId: json['deviceId'],
    );
  }
}
