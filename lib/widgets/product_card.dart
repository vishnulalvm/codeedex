import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/product_model.dart';
import 'cached_image.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onFavoritePressed;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onFavoritePressed,
    required this.onAddToCart,
  });

  bool get _isNetworkImage =>
      product.image.startsWith('http') || product.image.startsWith('https');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
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
                  child: _isNetworkImage
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
              Positioned(
                top: 8.h,
                right: 8.w,
                child: InkWell(
                  onTap: onFavoritePressed,
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
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.category,
                  style: TextStyle(
                    fontFamily: 'Lufga',
                    fontSize: 11.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  product.name,
                  style: TextStyle(
                    fontFamily: 'Lufga',
                    fontSize: 13.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      if (product.originalPrice > 0)
                        Text(
                          'QAR ${product.originalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontFamily: 'Lufga',
                            fontSize: 11.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      if (product.originalPrice > 0) SizedBox(width: 6.w),
                      Text(
                        'QAR ${product.discountedPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontFamily: 'Lufga',
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  height: 32.h,
                  child: OutlinedButton(
                    onPressed: onAddToCart,
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
                          style: TextStyle(
                            fontFamily: 'Lufga',
                            fontSize: 13.sp,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
