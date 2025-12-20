class RegisterData {
  final String? userMainImageUri;
  final String name;
  final String gender;
  final String email;
  final bool emailVerified;
  final String keyPhrase;

  const RegisterData({
    this.userMainImageUri,
    required this.name,
    required this.gender,
    required this.email,
    this.emailVerified = false,
    required this.keyPhrase,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      userMainImageUri: json['user_main_image_uri'] as String?,
      name: json['name'] as String,
      gender: json['gender'] as String,
      email: json['email'] as String,
      emailVerified: json['email_verified'] as bool? ?? false,
      keyPhrase: json['key_phrase'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_main_image_uri': userMainImageUri,
      'name': name,
      'gender': gender,
      'email': email,
      'email_verified': emailVerified,
      'key_phrase': keyPhrase,
    };
  }
}
