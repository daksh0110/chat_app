import 'package:chat_app/modal/register_data.dart';
import 'package:dio/dio.dart';

class AuthenticationApiServcie {
  final Dio dio;

  const AuthenticationApiServcie({required this.dio});

  Future<Response> register(RegisterData data) async {
    try {
      final response = await dio.post(
        '/authentication/register',
        data: data.toJson(),
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? e.message);
    }
  }

  Future<Response> sendOtp({required String email}) async {
    try {
      final response = await dio.post(
        '/authentication/verify-user',
        data: {"email": email},
      );
      print("this is the repsonse $response");
      return response;
    } on DioException catch (e) {
      print(e);
      if (e.response != null) {
        return e.response!;
      }

      throw Exception(e.message ?? 'Network error');
    }
  }
}
