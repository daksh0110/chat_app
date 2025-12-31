class AuthenticationData {
  final String accessToken;
  final String refreshToken;
  final String deviceId;

  const AuthenticationData({
    required this.accessToken,
    required this.deviceId,
    required this.refreshToken,
  });

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "deviceId": deviceId,
  };
}
