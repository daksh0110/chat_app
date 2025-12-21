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
}
