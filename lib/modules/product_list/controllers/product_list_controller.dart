import 'package:get/get.dart';
import '../../../models/product_model.dart';

class ProductListController extends GetxController {
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxMap<String, int> cartQuantities = <String, int>{}.obs;
  final RxString categoryName = ''.obs;
  final RxInt totalItems = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      categoryName.value = args['categoryName'] ?? 'Products';
      loadProducts();
    }
  }

  void loadProducts() {
    products.value = [
      ProductModel(
        id: '1',
        name: 'Chana dal 1KG',
        category: 'Unpolished Pulses',
        originalPrice: 105.00,
        discountedPrice: 80.00,
        weight: '1kg',
        image: 'assets/image/itemone.png',
      ),
      ProductModel(
        id: '2',
        name: 'Roasted Chana 750g',
        category: 'Unpolished Pulses',
        originalPrice: 95.00,
        discountedPrice: 125.00,
        weight: '750g',
        image: 'assets/image/itemone.png',
      ),
      ProductModel(
        id: '3',
        name: 'Toor Dal 1KG',
        category: 'Unpolished Pulses',
        originalPrice: 153.00,
        discountedPrice: 210.00,
        weight: '1kg',
        image: 'assets/image/itemone.png',
      ),
      ProductModel(
        id: '4',
        name: 'Red Chana 1 kg',
        category: 'Unpolished Pulses',
        originalPrice: 95.00,
        discountedPrice: 135.00,
        weight: '1kg',
        image: 'assets/image/itemone.png',
      ),
      ProductModel(
        id: '5',
        name: 'Grenn Moong 500G',
        category: 'Unpolished Pulses',
        originalPrice: 72.00,
        discountedPrice: 90.00,
        weight: '500g',
        image: 'assets/image/itemone.png',
      ),
      ProductModel(
        id: '6',
        name: 'Masoor Dal 1KG',
        category: 'Unpolished Pulses',
        originalPrice: 0,
        discountedPrice: 125.00,
        weight: '1kg',
        image: 'assets/image/itemone.png',
      ),
      ProductModel(
        id: '7',
        name: 'Ground Nuts 500g',
        category: 'Unpolished Pulses',
        originalPrice: 86.00,
        discountedPrice: 105.00,
        weight: '500g',
        image: 'assets/image/itemone.png',
      ),
      ProductModel(
        id: '8',
        name: 'Urad Dal 1KG',
        category: 'Unpolished Pulses',
        originalPrice: 150.00,
        discountedPrice: 180.00,
        weight: '1kg',
        image: 'assets/image/itemone.png',
      ),
    ];
    totalItems.value = products.length;
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
