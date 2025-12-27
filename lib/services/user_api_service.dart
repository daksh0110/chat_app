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
}
