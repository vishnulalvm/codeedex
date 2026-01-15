import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/product_model.dart';
import '../../../services/product_service.dart';

class ProductListController extends GetxController {
  final ProductService _productService = ProductService();

  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxMap<String, int> cartQuantities = <String, int>{}.obs;
  final RxString categoryName = ''.obs;
  final RxString categorySlug = ''.obs;
  final RxInt totalItems = 0.obs;

  // Pagination
  final RxInt currentPage = 1.obs;
  final RxInt lastPage = 1.obs;
  final RxBool hasMorePages = false.obs;
  final RxBool isLoadingMore = false.obs;

  // Loading states
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  // Filters and sorting
  final RxString sortBy = ''.obs;
  final RxString sortOrder = ''.obs;
  final RxString filterBy = 'category'.obs; // category, brand, store

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      categoryName.value = args['categoryName'] ?? 'Products';
      categorySlug.value = args['categorySlug'] ?? '';
      filterBy.value = args['filterBy'] ?? 'category';
      loadProducts();
    }
  }

  Future<void> loadProducts({bool refresh = false}) async {
    try {
      if (refresh) {
        currentPage.value = 1;
        products.clear();
      }

      isLoading.value = true;
      hasError.value = false;

      final response = await _productService.getProducts(
        by: categorySlug.isNotEmpty ? filterBy.value : null,
        value: categorySlug.isNotEmpty ? categorySlug.value : null,
        sortBy: sortBy.value.isNotEmpty ? sortBy.value : null,
        sortOrder: sortOrder.value.isNotEmpty ? sortOrder.value : null,
        page: currentPage.value,
      );

      if (response.isSuccess) {
        // Convert API products to ProductModel
        final newProducts = response.products.map((p) {
          return ProductModel(
            id: p.slug,
            name: p.name,
            category: p.store.isNotEmpty ? p.store : p.manufacturer,
            originalPrice: p.oldPriceValue,
            discountedPrice: p.priceValue,
            weight: '',
            image: p.image,
            slug: p.slug,
            store: p.store,
            manufacturer: p.manufacturer,
          );
        }).toList();

        if (refresh) {
          products.value = newProducts;
        } else {
          products.addAll(newProducts);
        }

        // Update pagination data
        if (response.pagination != null) {
          currentPage.value = response.pagination!.currentPage;
          lastPage.value = response.pagination!.lastPage;
          hasMorePages.value = response.pagination!.hasMorePages;
          totalItems.value = response.pagination!.total;
        } else {
          totalItems.value = products.length;
        }
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
      isLoadingMore.value = false;
    }
  }

  Future<void> loadMoreProducts() async {
    if (isLoadingMore.value || !hasMorePages.value) return;

    isLoadingMore.value = true;
    currentPage.value++;
    await loadProducts();
  }

  Future<void> refreshProducts() async {
    await loadProducts(refresh: true);
  }

  void applySorting(String sortByValue, String sortOrderValue) {
    sortBy.value = sortByValue;
    sortOrder.value = sortOrderValue;
    loadProducts(refresh: true);
  }

  String getProductImageUrl(String imagePath) {
    if (imagePath.isEmpty) return '';
    if (imagePath.startsWith('http')) return imagePath;
    return imagePath;
  }

  int getDiscountPercentage(ProductModel product) {
    if (product.originalPrice == 0) return 0;
    return (((product.discountedPrice - product.originalPrice) /
                product.discountedPrice) *
            100)
        .round();
  }

  void toggleFavorite(String productId) {
    final index = products.indexWhere((p) => p.id == productId);
    if (index != -1) {
      products[index] = products[index].copyWith(
        isFavorite: !products[index].isFavorite,
      );
    }
  }

  void addToCart(String productId) {
    cartQuantities[productId] = 1;
    Get.snackbar(
      'Added to Cart',
      'Item added to cart',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }

  void incrementQuantity(String productId) {
    if (cartQuantities.containsKey(productId)) {
      cartQuantities[productId] = cartQuantities[productId]! + 1;
    }
  }

  void decrementQuantity(String productId) {
    if (cartQuantities.containsKey(productId)) {
      if (cartQuantities[productId]! > 1) {
        cartQuantities[productId] = cartQuantities[productId]! - 1;
      } else {
        cartQuantities.remove(productId);
      }
    }
  }

  bool isInCart(String productId) {
    return cartQuantities.containsKey(productId);
  }

  int getQuantity(String productId) {
    return cartQuantities[productId] ?? 0;
  }

  void openSortBy() {
    Get.snackbar(
      'Sort By',
      'Sort functionality coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void openFilter() {
    Get.snackbar(
      'Filter',
      'Filter functionality coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void goToProductDetail(ProductModel product) {
    Get.toNamed(
      '/product-detail',
      arguments: {'product': product},
    );
  }
}
