import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../models/product_list_response_model.dart';
import '../services/storage_service.dart';
import 'api_client.dart';

class ProductService {
  final ApiClient _apiClient = ApiClient();
  final StorageService _storageService = StorageService();

  /// Fetch products list
  /// [by] - Filter by: category, brand, store
  /// [value] - The slug value to filter by
  /// [sortBy] - Sort by: price, name, date, rating, popularity
  /// [sortOrder] - Sort order: asc, desc
  /// [page] - Page number for pagination
  /// [filters] - JSON string with filters
  Future<ProductListResponse> getProducts({
    String? by,
    String? value,
    String? sortBy,
    String? sortOrder,
    int page = 1,
    String? filters,
  }) async {
    try {
      // Get stored user credentials
      final userId = _storageService.getUserId();
      final token = _storageService.getToken();

      // Build query parameters
      final queryParams = <String, dynamic>{
        if (userId != null) 'id': userId,
        if (token != null) 'token': token,
        if (by != null) 'by': by,
        if (value != null) 'value': value,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        if (page > 1) 'page': page,
        if (filters != null) 'filters': filters,
      };

      final response = await _apiClient.post(
        ApiConstants.products,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ProductListResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            e.response?.data['message'] ?? 'Failed to load products');
      } else {
        throw Exception('Network error. Please check your connection.');
      }
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  /// Search products by name
  Future<ProductListResponse> searchProducts({
    required String query,
    int page = 1,
  }) async {
    return getProducts(
      value: query,
      page: page,
    );
  }

  /// Get products by category
  Future<ProductListResponse> getProductsByCategory({
    required String categorySlug,
    String? sortBy,
    String? sortOrder,
    int page = 1,
  }) async {
    return getProducts(
      by: 'category',
      value: categorySlug,
      sortBy: sortBy,
      sortOrder: sortOrder,
      page: page,
    );
  }

  /// Get products by brand
  Future<ProductListResponse> getProductsByBrand({
    required String brandSlug,
    int page = 1,
  }) async {
    return getProducts(
      by: 'brand',
      value: brandSlug,
      page: page,
    );
  }

  /// Get products by store
  Future<ProductListResponse> getProductsByStore({
    required String storeSlug,
    int page = 1,
  }) async {
    return getProducts(
      by: 'store',
      value: storeSlug,
      page: page,
    );
  }
}
