import 'package:get/get.dart';
import '../../../models/product_model.dart';

class ProductDetailController extends GetxController {
  final Rx<ProductModel?> product = Rx<ProductModel?>(null);
  final RxInt quantity = 1.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['product'] != null) {
      product.value = args['product'];
    }
  }

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void addToCart() {
    Get.snackbar(
      'Added to Cart',
      '${product.value?.name} (${quantity.value}) added to cart',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void toggleFavorite() {
    if (product.value != null) {
      product.value = product.value!.copyWith(
        isFavorite: !product.value!.isFavorite,
      );
    }
  }
}
