import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/product_detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
          onPressed: () => Get.back(),
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
      body: Obx(
        () {
          if (controller.product.value == null) {
            return const Center(child: Text('Product not found'));
          }

          final product = controller.product.value!;
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildImageCarousel(product),
                      SizedBox(height: 20.h),
                      _buildProductInfo(product),
                      SizedBox(height: 24.h),
                      _buildDescription(),
                      SizedBox(height: 32.h),
                      _buildRelatedProducts(),
                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildImageCarousel(product) {
    return Container(
      height: 380.h,
      width: double.infinity,
      color: Colors.white,
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(16.w),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Image.asset(
                product.image,
                height: 280.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            top: 16.h,
            right: 16.w,
            child: Obx(
              () => InkWell(
                onTap: controller.toggleFavorite,
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    controller.product.value?.isFavorite ?? false
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: controller.product.value?.isFavorite ?? false
                        ? Colors.red
                        : Colors.grey,
                    size: 24.sp,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  width: index == 0 ? 24.w : 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: index == 0 ? const Color(0xFF8B4513) : Colors.grey[300],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductInfo(product) {
    final discount = product.originalPrice > 0
        ? (((product.discountedPrice - product.originalPrice) /
                    product.discountedPrice) *
                100)
            .round()
        : 0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: GoogleFonts.getFont(
              'Lufga',
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            product.category,
            style: GoogleFonts.getFont(
              'Lufga',
              fontSize: 14.sp,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Text(
                '₹ ${product.originalPrice.toStringAsFixed(2)}',
                style: GoogleFonts.getFont(
                  'Lufga',
                  fontSize: 16.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  decoration: product.originalPrice > 0
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '₹ ${product.discountedPrice.toStringAsFixed(2)}',
                style: GoogleFonts.getFont(
                  'Lufga',
                  fontSize: 24.sp,
                  color: const Color(0xFF8B4513),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 12.w),
              if (discount > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B4513).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    '($discount% off)',
                    style: GoogleFonts.getFont(
                      'Lufga',
                      fontSize: 14.sp,
                      color: const Color(0xFF8B4513),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.share_outlined,
                  color: Colors.grey[600],
                  size: 24.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: GoogleFonts.getFont(
              'Lufga',
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Bag of Green offers premium Strawberries from South Africa, prized for their vibrant red color, natural sweetness, and juicy texture. Perfect for snacking, desserts, and smoothies, these strawberries are carefully sourced and delivered fresh anywhere in the UAE. Enjoy the delicious taste and quality of South African strawberries at your convenience.',
            style: GoogleFonts.getFont(
              'Lufga',
              fontSize: 14.sp,
              color: Colors.grey[700],
              fontWeight: FontWeight.w400,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'Related Products',
            style: GoogleFonts.getFont(
              'Lufga',
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 260.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            itemCount: 2,
            itemBuilder: (context, index) {
              return _buildRelatedProductCard(
                index == 0 ? 'Chana dal 1KG' : 'Roasted Chana 750g',
                index == 0 ? 105.00 : 95.00,
                index == 0 ? 80.00 : 125.00,
                index == 0 ? '22% off' : '24% off',
                index == 0,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRelatedProductCard(
    String name,
    double originalPrice,
    double discountedPrice,
    String discount,
    bool showQuantity,
  ) {
    return Container(
      width: 160.w,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
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
                height: 130.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/image/itemone.png',
                    height: 90.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: 8.h,
                left: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B4513),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    discount,
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
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.grey,
                    size: 16.sp,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.getFont(
                    'Lufga',
                    fontSize: 13.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      '₹ ${originalPrice.toStringAsFixed(2)}',
                      style: GoogleFonts.getFont(
                        'Lufga',
                        fontSize: 11.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      '₹ ${discountedPrice.toStringAsFixed(2)}',
                      style: GoogleFonts.getFont(
                        'Lufga',
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                showQuantity
                    ? Container(
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF8B4513),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: SizedBox(
                                width: 32.w,
                                height: 32.h,
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 16.sp,
                                ),
                              ),
                            ),
                            Text(
                              '1',
                              style: GoogleFonts.getFont(
                                'Lufga',
                                fontSize: 14.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: SizedBox(
                                width: 32.w,
                                height: 32.h,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 16.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: 32.h,
                        child: OutlinedButton(
                          onPressed: () {},
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
                                  fontSize: 13.sp,
                                  color: const Color(0xFF8B4513),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Icon(
                                Icons.shopping_cart_outlined,
                                color: const Color(0xFF8B4513),
                                size: 14.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 56.h,
          child: ElevatedButton(
            onPressed: controller.addToCart,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B4513),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add To Cart',
                  style: GoogleFonts.getFont(
                    'Lufga',
                    fontSize: 18.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 12.w),
                Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                  size: 22.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
