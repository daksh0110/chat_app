import 'package:chat_app/modal/api_response.dart';
import 'package:chat_app/modal/backend/register_user_response.dart';
import 'package:chat_app/modal/backend/verify_otp_response.dart';
import 'package:chat_app/modal/register_data.dart';
import 'package:dio/dio.dart';

class AuthenticationApiServcie {
  final Dio dio;

  const AuthenticationApiServcie({required this.dio});

  Future<ApiResponse<RegisterUserData>> register(RegisterData data) async {
    try {
      final response = await dio.post(
        '/authentication/register',
        data: data.toJson(),
      );
      final json = response.data;
      return ApiResponse.fromJson(
        json,
        (data) => RegisterUserData.fromJson(data),
      );
    } on DioException catch (e) {
      if (e.response != null) {
        final json = e.response!.data as Map<String, dynamic>;
        return ApiResponse.fromJson(
          json,
          (data) => RegisterUserData.fromJson(data),
        );
      }
      throw Exception(e.response?.data ?? e.message);
    }
  }

  Future<ApiResponse> sendOtp({required String email}) async {
    try {
      final response = await dio.post(
        '/authentication/verify-user',
        data: {"email": email},
      );
      final json = response.data;
      return ApiResponse(success: json["success"], message: json["message"]);
    } on DioException catch (e) {
      if (e.response != null) {
        final json = e.response!.data as Map<String, dynamic>;
        return ApiResponse(success: json["success"], message: json["message"]);
      }

      throw Exception(e.message ?? 'Network error');
    }
  }

  Future<ApiResponse<VerifyOtpData>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await dio.post(
        "/authentication/verify-otp",
        data: {"email": email, "otp": otp},
      );
      final json = response.data;
      return ApiResponse<VerifyOtpData>.fromJson(
        json,
        (data) => VerifyOtpData.fromJson(data),
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        final json = e.response!.data as Map<String, dynamic>;

        return ApiResponse<VerifyOtpData>.fromJson(
          json,
          (data) => VerifyOtpData.fromJson(data),
        );
      }
      throw Exception(e.response?.data ?? e.message);
    }
  }
}
