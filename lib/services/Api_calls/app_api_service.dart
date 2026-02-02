import 'package:chat_app/modal/api_response.dart';
import 'package:chat_app/modal/backend/check_updated_version.dart';
import 'package:dio/dio.dart';

class AppApiService {
  final Dio dio;

  const AppApiService({required this.dio});

  Future<ApiResponse<CheckUpdatedVersion>> checkUpdatedversion(
    String version,
  ) async {
    try {
      final response = await dio.post(
        "/app/check-version",
        data: {"version": version},
      );
      final json = response.data;
      return ApiResponse.fromJson(
        json,
        (json) => CheckUpdatedVersion.fromJson(json),
      );
    } on DioException catch (e) {
      if (e.response != null) {
        final json = e.response!.data as Map<String, dynamic>;
        return ApiResponse.fromJson(
          json,
          (data) => CheckUpdatedVersion.fromJson(data),
        );
      }
      throw Exception(e.message ?? 'Network error');
    }
  }
}
