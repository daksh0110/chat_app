import 'package:chat_app/modal/api_response.dart';
import 'package:chat_app/modal/authentication_data.dart';
import 'package:chat_app/modal/backend/verify_token_response.dart';
import 'package:chat_app/modal/chat_search_item.dart';
import 'package:dio/dio.dart';

class UserApiService {
  final Dio dio;

  const UserApiService({required this.dio});

  Future<List<ChatSearchItem>> getUsers(String name) async {
    try {
      final response = await dio.get("/users/search?q=$name");
      final List<dynamic> list = response.data["data"];

      return list.map((e) => ChatSearchItem.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data["message"] ?? "Server error");
      }
      throw Exception(e.message ?? 'Network error');
    }
  }

  Future<ApiResponse<VerifyTokenResponse>> verifyUser(
    AuthenticationData data,
  ) async {
    try {
      final response = await dio.post("/users/me", data: data.toJson());
      final json = response.data;
      return ApiResponse.fromJson(
        json,
        (json) => VerifyTokenResponse.fromJson(json),
      );
    } on DioException catch (e) {
      if (e.response != null) {
        final json = e.response!.data as Map<String, dynamic>;
        return ApiResponse.fromJson(
          json,
          (data) => VerifyTokenResponse.fromJson(data),
        );
      }
      throw Exception(e.message ?? 'Network error');
    }
  }
}
