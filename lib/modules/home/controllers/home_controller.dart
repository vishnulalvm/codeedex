import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/category_model.dart';
import '../../../models/product_model.dart';
import '../../../models/home_response_model.dart';
import '../../../services/home_service.dart';
import '../../../services/storage_service.dart';
import '../../../constants/api_constants.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  final HomeService _homeService = HomeService();
  final StorageService _storageService = StorageService();

  final RxInt currentCarouselIndex = 0.obs;
  final RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  final RxList<ProductModel> dailyBestSelling = <ProductModel>[].obs;
  final RxList<ProductModel> recentlyAdded = <ProductModel>[].obs;
  final RxList<ProductModel> popularProducts = <ProductModel>[].obs;
  final RxList<ProductModel> trendingProducts = <ProductModel>[].obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;
  final RxList<BannerModel> adBanners = <BannerModel>[].obs;
  final RxList<FeaturedBrand> featuredBrands = <FeaturedBrand>[].obs;

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt cartCount = 0.obs;
  final RxInt notificationCount = 0.obs;
  final Rx<CurrencyModel?> currency = Rx<CurrencyModel?>(null);

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final response = await _homeService.getHomeData();

      if (response.isSuccess) {
        // Load banners
        if (response.banner1.isNotEmpty) {
          banners.value = response.banner1;
        }

        // Load ad banners (using banner2)
        if (response.banner2.isNotEmpty) {
          adBanners.value = response.banner2;
        }

        // Load categories
        categories.value = response.categories
            .map(
              (item) => CategoryModel.fromJson({
                'category': {
                  'id': item.category.id,
                  'name': item.category.name,
                  'image': item.category.image,
                  'slug': item.category.slug,
                  'description': item.category.description,
                },
                'subcategory': item.subcategory,
              }),
            )
            .toList();

        // Load products from different sections
        featuredProducts.value = response.ourProducts
            .map(
              (p) => ProductModel.fromJson({
                'slug': p.slug,
                'name': p.name,
                'store': p.store,
                'manufacturer': p.manufacturer,
                'oldprice': p.oldPrice,
                'price': p.price,
                'image': getProductImageUrl(p.image),
              }),
            )
            .toList();

        dailyBestSelling.value = response.bestSeller
            .map(
              (p) => ProductModel.fromJson({
                'slug': p.slug,
                'name': p.name,
                'store': p.store,
                'manufacturer': p.manufacturer,
                'oldprice': p.oldPrice,
                'price': p.price,
                'image': getProductImageUrl(p.image),
              }),
            )
            .toList();

        recentlyAdded.value = response.newArrivals
            .map(
              (p) => ProductModel.fromJson({
                'slug': p.slug,
                'name': p.name,
                'store': p.store,
                'manufacturer': p.manufacturer,
                'oldprice': p.oldPrice,
                'price': p.price,
                'image': getProductImageUrl(p.image),
              }),
            )
            .toList();

        popularProducts.value = response.suggestedProducts
            .map(
              (p) => ProductModel.fromJson({
                'slug': p.slug,
                'name': p.name,
                'store': p.store,
                'manufacturer': p.manufacturer,
                'oldprice': p.oldPrice,
                'price': p.price,
                'image': getProductImageUrl(p.image),
              }),
            )
            .toList();

        trendingProducts.value = response.flashSale
            .map(
              (p) => ProductModel.fromJson({
                'slug': p.slug,
                'name': p.name,
                'store': p.store,
                'manufacturer': p.manufacturer,
                'oldprice': p.oldPrice,
                'price': p.price,
                'image': getProductImageUrl(p.image),
              }),
            )
            .toList();

        // Load other data
        featuredBrands.value = response.featuredBrands;
        cartCount.value = response.cartCount;
        notificationCount.value = response.notificationCount;
        currency.value = response.currency;
      } else {
        hasError.value = true;
        errorMessage.value = response.message;
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString().replaceAll('Exception: ', '');

      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  String getImageUrl(String imagePath) {
    if (imagePath.isEmpty) return '';
    if (imagePath.startsWith('http')) return imagePath;
    return '${ApiConstants.imageBaseUrl}/images/banner/$imagePath';
  }

  String getCategoryImageUrl(String imagePath) {
    if (imagePath.isEmpty) return '';
    if (imagePath.startsWith('http')) return imagePath;
    return '${ApiConstants.imageBaseUrl}/images/category/$imagePath';
  }

  String getProductImageUrl(String imagePath) {
    if (imagePath.isEmpty) return '';
    if (imagePath.startsWith('http')) return imagePath;
    return '${ApiConstants.imageBaseUrl}/images/product/$imagePath';
  }

  String getBrandImageUrl(String imagePath) {
    if (imagePath.isEmpty) return '';
    if (imagePath.startsWith('http')) return imagePath;
    return '${ApiConstants.imageBaseUrl}/images/manufacturer/$imagePath';
  }

  void onCarouselChanged(int index) {
    currentCarouselIndex.value = index;
  }

  void toggleFavorite(String productId, String section) {
    switch (section) {
      case 'featured':
        _toggleInList(featuredProducts, productId);
        break;
      case 'daily':
        _toggleInList(dailyBestSelling, productId);
        break;
      case 'recent':
        _toggleInList(recentlyAdded, productId);
        break;
      case 'popular':
        _toggleInList(popularProducts, productId);
        break;
      case 'trending':
        _toggleInList(trendingProducts, productId);
        break;
    }
  }

  void _toggleInList(RxList<ProductModel> list, String productId) {
    final index = list.indexWhere((p) => p.id == productId);
    if (index != -1) {
      list[index] = list[index].copyWith(isFavorite: !list[index].isFavorite);
    }
  }

  void addToCart(ProductModel product) {
    Get.snackbar(
      'Added to Cart',
      '${product.name} added to cart',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> logout() async {
    try {
      // Clear authentication data
      await _storageService.clearAuthData();

      // Navigate to login screen
      Get.offAllNamed(Routes.LOGIN);

      // Show success message
      Get.snackbar(
        'Logged Out',
        'You have been logged out successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withValues(alpha: 0.1),
        colorText: Colors.green,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to logout. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red,
      );
    }
  }
}
