import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../models/home_response_model.dart';
import '../services/storage_service.dart';
import 'api_client.dart';

class HomeService {
  final ApiClient _apiClient = ApiClient();
  final StorageService _storageService = StorageService();

  Future<HomeResponse> getHomeData() async {
    try {
      // Get stored user credentials
      final userId = _storageService.getUserId();
      final token = _storageService.getToken();

      // Build query parameters
      final queryParams = <String, dynamic>{};
      if (userId != null) queryParams['id'] = userId;
      if (token != null) queryParams['token'] = token;

      final response = await _apiClient.post(
        ApiConstants.home,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return HomeResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load home data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            e.response?.data['message'] ?? 'Failed to load home data');
      } else {
        throw Exception('Network error. Please check your connection.');
      }
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
