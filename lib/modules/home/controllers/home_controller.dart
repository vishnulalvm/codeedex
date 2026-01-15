import 'package:get/get.dart';
import '../../../models/category_model.dart';
import '../../../models/product_model.dart';

class HomeController extends GetxController {
  final RxInt currentCarouselIndex = 0.obs;
  final RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  final RxList<ProductModel> dailyBestSelling = <ProductModel>[].obs;
  final RxList<ProductModel> recentlyAdded = <ProductModel>[].obs;
  final RxList<ProductModel> popularProducts = <ProductModel>[].obs;
  final RxList<ProductModel> trendingProducts = <ProductModel>[].obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
    loadProducts();
  }

  void loadCategories() {
    categories.value = [
      CategoryModel(
        id: '1',
        name: 'Unpolished\nPulses',
        image: 'assets/image/incradient.png',
      ),
      CategoryModel(
        id: '2',
        name: 'Unpolished\nRice',
        image: 'assets/image/incradient.png',
      ),
      CategoryModel(
        id: '3',
        name: 'Unpolished\nMillets',
        image: 'assets/image/incradient.png',
      ),
      CategoryModel(
        id: '4',
        name: 'Nuts & Dry\nFruits',
        image: 'assets/image/incradient.png',
      ),
      CategoryModel(
        id: '5',
        name: 'Unpolished\nFlours',
        image: 'assets/image/incradient.png',
      ),
    ];
  }

  void loadProducts() {
    featuredProducts.value = [
      ProductModel(
        id: '1',
        name: 'Light pink salt 1 kg',
        category: 'Flours & Supers',
        originalPrice: 67.00,
        discountedPrice: 80.00,
        weight: '1kg',
        image: 'assets/image/itemone.png',
      ),
      ProductModel(
        id: '2',
        name: 'Idly ravva 1 kg',
        category: 'Flours & Supers',
        originalPrice: 46.00,
        discountedPrice: 65.00,
        weight: '1kg',
        image: 'assets/image/itemone.png',
      ),
    ];

    dailyBestSelling.value = [
      ProductModel(
        id: '3',
        name: 'Black Eyed Peas-1kg',
        category: 'Unpolished Pulses',
        originalPrice: 90.00,
        discountedPrice: 130.00,
        weight: '1kg',
        image: 'assets/image/itemone.png',
      ),
      ProductModel(
        id: '4',
        name: 'Browntop millet 1KG',
        category: 'Unpolished Millets',
        originalPrice: 175.00,
        discountedPrice: 230.00,
        weight: '1kg',
        image: 'assets/image/itemone.png',
      ),
    ];

    recentlyAdded.value = [
      ProductModel(
        id: '5',
        name: 'Cashew nuts 250g',
        category: 'Nuts & Dry Fruits',
        originalPrice: 270.00,
        discountedPrice: 400.00,
        weight: '250g',
        image: 'assets/image/itemone.png',
      ),
      ProductModel(
        id: '6',
        name: 'Almonds 500g',
        category: 'Nuts & Dry Fruits',
        originalPrice: 80.00,
        discountedPrice: 700.00,
        weight: '500g',
        image: 'assets/image/itemone.png',
      ),
    ];

    popularProducts.value = [
      ProductModel(
        id: '7',
        name: 'Black Eyed Peas-1kg',
        category: 'Unpolished Pulses',
        originalPrice: 90.00,
        discountedPrice: 130.00,
        weight: '1kg',
        image: 'assets/image/itemone.png',
      ),
      ProductModel(
        id: '8',
        name: 'Idly ravva 1 kg',
        category: 'Flours & Supers',
        originalPrice: 46.00,
        discountedPrice: 65.00,
        weight: '1kg',
        image: 'assets/image/itemone.png',
      ),
    ];

    trendingProducts.value = [
      ProductModel(
        id: '9',
        name: 'Browntop millet 1KG',
        category: 'Unpolished Millets',
        originalPrice: 174.00,
        discountedPrice: 235.00,
        weight: '1kg',
        image: 'assets/image/itemone.png',
      ),
      ProductModel(
        id: '10',
        name: 'Light pink salt 1 kg',
        category: 'Flours & Supers',
        originalPrice: 67.00,
        discountedPrice: 80.00,
        weight: '1kg',
        image: 'assets/image/itemone.png',
      ),
    ];
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
}
