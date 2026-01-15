import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widgets/product_card.dart';
import '../../../widgets/cached_image.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF8B4513),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            'assets/image/incradient.png',
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {},
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
              Obx(() {
                if (controller.notificationCount.value > 0) {
                  return Positioned(
                    right: 8,
                    top: 8,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        '${controller.notificationCount.value}',
                        style: TextStyle(fontSize: 10.sp, color: Colors.white),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                SizedBox(height: 16.h),
                Text(
                  controller.errorMessage.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Lufga', fontSize: 16.sp),
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: controller.loadHomeData,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.loadHomeData,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                _buildCarousel(),
                SizedBox(height: 20.h),
                _buildCategories(),
                SizedBox(height: 24.h),
                _buildFeaturedProducts(),
                SizedBox(height: 24.h),
                _buildDailyBestSelling(),
                SizedBox(height: 24.h),
                _buildAdBanner(),
                SizedBox(height: 24.h),
                _buildRecentlyAdded(),
                SizedBox(height: 24.h),
                _buildPopularProducts(),
                SizedBox(height: 24.h),
                _buildTrendingProducts(),
                SizedBox(height: 80.h),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildCarousel() {
    return Obx(() {
      if (controller.banners.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        children: [
          carousel.CarouselSlider(
            options: carousel.CarouselOptions(
              height: 200.h,
              viewportFraction: 0.92,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              enlargeCenterPage: true,
              enlargeFactor: 0.2,
              onPageChanged: (index, reason) {
                controller.onCarouselChanged(index);
              },
            ),
            items: controller.banners.map((banner) {
              return _buildCarouselItemFromApi(
                banner.title,
                banner.subTitle,
                controller.getImageUrl(
                  banner.mobileImage.isNotEmpty
                      ? banner.mobileImage
                      : banner.image,
                ),
                const Color(0xFFFF8C42),
                banner.buttonText,
              );
            }).toList(),
          ),
        ],
      );
    });
  }

  Widget _buildCarouselItemFromApi(
    String title,
    String subtitle,
    String imagePath,
    Color backgroundColor,
    String buttonText,
  ) {
    final bool isNetworkImage =
        imagePath.startsWith('http') || imagePath.startsWith('https');

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: isNetworkImage
            ? CachedImage(
                imageUrl: imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              )
            : Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontFamily: 'Lufga',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, size: 16.sp),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, size: 16.sp),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 110.h,
          child: Obx(
            () => ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                final category = controller.categories[index];
                final imageUrl = controller.getCategoryImageUrl(category.image);
                final bool isNetworkImage = imageUrl.startsWith('http');

                return GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      '/product-list',
                      arguments: {
                        'categoryName': category.name.replaceAll('\n', ' '),
                      },
                    );
                  },
                  child: Container(
                    width: 80.w,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Column(
                      children: [
                        Container(
                          width: 70.w,
                          height: 70.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: isNetworkImage
                                ? CachedImage(
                                    imageUrl: imageUrl,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    category.image,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          category.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Lufga',
                            fontSize: 11.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedProducts() {
    return _buildProductSection(
      'Featured Products',
      controller.featuredProducts,
      'featured',
    );
  }

  Widget _buildDailyBestSelling() {
    return _buildProductSection(
      'Daily Best Selling',
      controller.dailyBestSelling,
      'daily',
    );
  }

  Widget _buildRecentlyAdded() {
    return _buildProductSection(
      'Recently Added',
      controller.recentlyAdded,
      'recent',
    );
  }

  Widget _buildPopularProducts() {
    return _buildProductSection(
      'Popular Products',
      controller.popularProducts,
      'popular',
    );
  }

  Widget _buildTrendingProducts() {
    return _buildProductSection(
      'Trending Products',
      controller.trendingProducts,
      'trending',
    );
  }

  Widget _buildProductSection(String title, RxList products, String section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Lufga',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, size: 16.sp),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, size: 16.sp),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 310.h,
          child: Obx(
            () => ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: ProductCard(
                    product: product,
                    onFavoritePressed: () {
                      controller.toggleFavorite(product.id, section);
                    },
                    onAddToCart: () {
                      controller.addToCart(product);
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdBanner() {
    return Obx(() {
      if (controller.adBanners.isEmpty) {
        return const SizedBox.shrink();
      }

      final banner = controller.adBanners.first;

      if (banner.image.isEmpty) {
        return const SizedBox.shrink();
      }

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: CachedImage(
            imageUrl: controller.getImageUrl(banner.image),
            width: double.infinity,
            height: 150.h,
            fit: BoxFit.cover,
          ),
        ),
      );
    });
  }

  Widget _buildBottomNav() {
    return Container(
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
      child: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF8B4513),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(
          fontFamily: 'Lufga',
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Lufga',
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart_outlined),
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: Colors.red,
                    child: Text(
                      '0',
                      style: TextStyle(fontSize: 8.sp, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
