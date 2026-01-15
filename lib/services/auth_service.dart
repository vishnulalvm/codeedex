import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import 'api_client.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _apiClient.postFormData(
        ApiConstants.login,
        data: request.toMap(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginResponse.fromJson(response.data);
      } else {
        throw Exception('Login failed with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Server responded with an error
        throw Exception(
            e.response?.data['message'] ?? 'Login failed. Please try again.');
      } else {
        // Network error or timeout
        throw Exception('Network error. Please check your connection.');
      }
    } catch (e) {
      print('An unexpected error occurred: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
