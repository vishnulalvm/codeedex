import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/product_model.dart';
import '../../../widgets/cached_image.dart';
import '../controllers/product_list_controller.dart';

class ProductListView extends GetView<ProductListController> {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
          onPressed: () => Get.back(),
        ),
        title: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.categoryName.value,
                style: GoogleFonts.getFont(
                  'Lufga',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '${controller.totalItems.value} Items',
                style: GoogleFonts.getFont(
                  'Lufga',
                  fontSize: 12.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black, size: 24.sp),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.black, size: 24.sp),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.products.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.hasError.value && controller.products.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 64, color: Colors.red),
                      SizedBox(height: 16.h),
                      Text(
                        controller.errorMessage.value,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont('Lufga', fontSize: 16.sp),
                      ),
                      SizedBox(height: 16.h),
                      ElevatedButton(
                        onPressed: controller.refreshProducts,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (controller.products.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_bag_outlined, size: 64.sp, color: Colors.grey),
                      SizedBox(height: 16.h),
                      Text(
                        'No products found',
                        style: GoogleFonts.getFont('Lufga', fontSize: 16.sp),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: controller.refreshProducts,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                      controller.loadMoreProducts();
                    }
                    return false;
                  },
                  child: GridView.builder(
                    padding: EdgeInsets.all(16.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.68,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                    ),
                    itemCount: controller.products.length + (controller.hasMorePages.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == controller.products.length) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: const CircularProgressIndicator(),
                          ),
                        );
                      }
                      final product = controller.products[index];
                      return _buildProductCard(product);
                    },
                  ),
                ),
              );
            }),
          ),
          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildProductCard(ProductModel product) {
    final discount = controller.getDiscountPercentage(product);

    return GestureDetector(
      onTap: () => controller.goToProductDetail(product),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 140.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
                  ),
                  child: Center(
                    child: product.image.startsWith('http')
                        ? CachedImage(
                            imageUrl: product.image,
                            height: 100.h,
                            fit: BoxFit.contain,
                          )
                        : Image.asset(
                            product.image,
                            height: 100.h,
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
                if (discount > 0)
                  Positioned(
                    top: 8.h,
                    left: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B4513),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        '$discount% off',
                        style: GoogleFonts.getFont(
                          'Lufga',
                          fontSize: 10.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Obx(
                    () => InkWell(
                      onTap: () => controller.toggleFavorite(product.id),
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          product.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: product.isFavorite ? Colors.red : Colors.grey,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: GoogleFonts.getFont(
                        'Lufga',
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        if (product.originalPrice > 0)
                          Text(
                            'QAR ${product.originalPrice.toStringAsFixed(2)}',
                            style: GoogleFonts.getFont(
                              'Lufga',
                              fontSize: 12.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        if (product.originalPrice > 0) SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            'QAR ${product.discountedPrice.toStringAsFixed(2)}',
                            style: GoogleFonts.getFont(
                              'Lufga',
                              fontSize: 15.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Obx(
                      () => controller.isInCart(product.id)
                          ? _buildQuantityControl(product.id)
                          : _buildAddButton(product.id),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(String productId) {
    return SizedBox(
      width: double.infinity,
      height: 36.h,
      child: OutlinedButton(
        onPressed: () => controller.addToCart(productId),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF8B4513)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add',
              style: GoogleFonts.getFont(
                'Lufga',
                fontSize: 14.sp,
                color: const Color(0xFF8B4513),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.shopping_cart_outlined,
              color: const Color(0xFF8B4513),
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityControl(String productId) {
    return Container(
      height: 36.h,
      decoration: BoxDecoration(
        color: const Color(0xFF8B4513),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => controller.decrementQuantity(productId),
            child: Container(
              width: 36.w,
              height: 36.h,
              alignment: Alignment.center,
              child: Icon(
                Icons.remove,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          Obx(
            () => Text(
              '${controller.getQuantity(productId)}',
              style: GoogleFonts.getFont(
                'Lufga',
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          InkWell(
            onTap: () => controller.incrementQuantity(productId),
            child: Container(
              width: 36.w,
              height: 36.h,
              alignment: Alignment.center,
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: controller.openSortBy,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.swap_vert,
                    color: Colors.black,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Sort By',
                    style: GoogleFonts.getFont(
                      'Lufga',
                      fontSize: 15.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: OutlinedButton(
              onPressed: controller.openFilter,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.filter_list,
                    color: Colors.black,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Filter',
                    style: GoogleFonts.getFont(
                      'Lufga',
                      fontSize: 15.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
