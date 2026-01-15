class HomeResponse {
  final int success;
  final String message;
  final List<BannerModel> banner1;
  final List<BannerModel> banner2;
  final List<BannerModel> banner3;
  final List<BannerModel> banner4;
  final List<BannerModel> banner5;
  final List<BannerModel> banner6;
  final List<BannerModel> banner7;
  final List<ProductItem> recentViews;
  final List<ProductItem> ourProducts;
  final List<ProductItem> suggestedProducts;
  final List<ProductItem> bestSeller;
  final List<ProductItem> flashSale;
  final List<ProductItem> newArrivals;
  final List<CategoryItem> categories;
  final List<CategoryItem> topAccessories;
  final List<FeaturedBrand> featuredBrands;
  final int cartCount;
  final int? wishlistCount;
  final CurrencyModel? currency;
  final dynamic address;
  final int notificationCount;

  HomeResponse({
    required this.success,
    required this.message,
    required this.banner1,
    required this.banner2,
    required this.banner3,
    required this.banner4,
    required this.banner5,
    required this.banner6,
    required this.banner7,
    required this.recentViews,
    required this.ourProducts,
    required this.suggestedProducts,
    required this.bestSeller,
    required this.flashSale,
    required this.newArrivals,
    required this.categories,
    required this.topAccessories,
    required this.featuredBrands,
    required this.cartCount,
    this.wishlistCount,
    this.currency,
    this.address,
    required this.notificationCount,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      success: _toInt(json['success']),
      message: json['message'] ?? '',
      banner1:
          (json['banner1'] as List<dynamic>?)
              ?.map((e) => BannerModel.fromJson(e))
              .toList() ??
          [],
      banner2:
          (json['banner2'] as List<dynamic>?)
              ?.map((e) => BannerModel.fromJson(e))
              .toList() ??
          [],
      banner3:
          (json['banner3'] as List<dynamic>?)
              ?.map((e) => BannerModel.fromJson(e))
              .toList() ??
          [],
      banner4:
          (json['banner4'] as List<dynamic>?)
              ?.map((e) => BannerModel.fromJson(e))
              .toList() ??
          [],
      banner5:
          (json['banner5'] as List<dynamic>?)
              ?.map((e) => BannerModel.fromJson(e))
              .toList() ??
          [],
      banner6:
          (json['banner6'] as List<dynamic>?)
              ?.map((e) => BannerModel.fromJson(e))
              .toList() ??
          [],
      banner7:
          (json['banner7'] as List<dynamic>?)
              ?.map((e) => BannerModel.fromJson(e))
              .toList() ??
          [],
      recentViews:
          (json['recentviews'] as List<dynamic>?)
              ?.map((e) => ProductItem.fromJson(e))
              .toList() ??
          [],
      ourProducts:
          (json['our_products'] as List<dynamic>?)
              ?.map((e) => ProductItem.fromJson(e))
              .toList() ??
          [],
      suggestedProducts:
          (json['suggested_products'] as List<dynamic>?)
              ?.map((e) => ProductItem.fromJson(e))
              .toList() ??
          [],
      bestSeller:
          (json['best_seller'] as List<dynamic>?)
              ?.map((e) => ProductItem.fromJson(e))
              .toList() ??
          [],
      flashSale:
          (json['flash_sail'] as List<dynamic>?)
              ?.map((e) => ProductItem.fromJson(e))
              .toList() ??
          [],
      newArrivals:
          (json['newarrivals'] as List<dynamic>?)
              ?.map((e) => ProductItem.fromJson(e))
              .toList() ??
          [],
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => CategoryItem.fromJson(e))
              .toList() ??
          [],
      topAccessories:
          (json['top_accessories'] as List<dynamic>?)
              ?.map((e) => CategoryItem.fromJson(e))
              .toList() ??
          [],
      featuredBrands:
          (json['featuredbrands'] as List<dynamic>?)
              ?.map((e) => FeaturedBrand.fromJson(e))
              .toList() ??
          [],
      cartCount: _toInt(json['cartcount']),
      wishlistCount: _toInt(json['wishlistcount']),
      currency: json['currency'] != null
          ? CurrencyModel.fromJson(json['currency'])
          : null,
      address: json['address'],
      notificationCount: _toInt(json['notification_count']),
    );
  }

  bool get isSuccess => success == 1;

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is List) return 0;
    return 0;
  }
}

class BannerModel {
  final int id;
  final int bannerTypeId;
  final int linkType;
  final String linkValue;
  final String image;
  final String mobileImage;
  final String title;
  final String subTitle;
  final String buttonText;

  BannerModel({
    required this.id,
    required this.bannerTypeId,
    required this.linkType,
    required this.linkValue,
    required this.image,
    required this.mobileImage,
    required this.title,
    required this.subTitle,
    required this.buttonText,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: HomeResponse._toInt(json['id']),
      bannerTypeId: HomeResponse._toInt(json['banner_type_id']),
      linkType: HomeResponse._toInt(json['link_type']),
      linkValue: json['link_value'] ?? '',
      image: json['image'] ?? '',
      mobileImage: json['mobile_image'] ?? '',
      title: json['title'] ?? '',
      subTitle: json['sub_title'] ?? '',
      buttonText: json['button_text'] ?? '',
    );
  }
}

class ProductItem {
  final String slug;
  final String name;
  final String store;
  final String manufacturer;
  final String symbolLeft;
  final String symbolRight;
  final String oldPrice;
  final String price;
  final String discount;
  final String image;

  ProductItem({
    required this.slug,
    required this.name,
    required this.store,
    required this.manufacturer,
    required this.symbolLeft,
    required this.symbolRight,
    required this.oldPrice,
    required this.price,
    required this.discount,
    required this.image,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      slug: json['slug'] ?? '',
      name: json['name'] ?? '',
      store: json['store'] ?? '',
      manufacturer: json['manufacturer'] ?? '',
      symbolLeft: json['symbol_left'] ?? '',
      symbolRight: json['symbol_right'] ?? '',
      oldPrice: json['oldprice']?.toString() ?? '0',
      price: json['price']?.toString() ?? '0',
      discount: json['discount']?.toString() ?? '0',
      image: json['image'] ?? '',
    );
  }

  double get priceValue => double.tryParse(price) ?? 0.0;
  double get oldPriceValue => double.tryParse(oldPrice) ?? 0.0;
}

class CategoryItem {
  final CategoryDetail category;
  final int subcategory;

  CategoryItem({required this.category, required this.subcategory});

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      category: CategoryDetail.fromJson(json['category'] ?? {}),
      subcategory: HomeResponse._toInt(json['subcategory']),
    );
  }
}

class CategoryDetail {
  final int id;
  final String? slug;
  final String image;
  final String name;
  final String description;

  CategoryDetail({
    required this.id,
    this.slug,
    required this.image,
    required this.name,
    required this.description,
  });

  factory CategoryDetail.fromJson(Map<String, dynamic> json) {
    return CategoryDetail(
      id: HomeResponse._toInt(json['id']),
      slug: json['slug'],
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class FeaturedBrand {
  final int id;
  final String image;
  final String slug;
  final String name;

  FeaturedBrand({
    required this.id,
    required this.image,
    required this.slug,
    required this.name,
  });

  factory FeaturedBrand.fromJson(Map<String, dynamic> json) {
    return FeaturedBrand(
      id: HomeResponse._toInt(json['id']),
      image: json['image'] ?? '',
      slug: json['slug'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class CurrencyModel {
  final String name;
  final String code;
  final String symbolLeft;
  final String symbolRight;
  final String value;
  final int status;

  CurrencyModel({
    required this.name,
    required this.code,
    required this.symbolLeft,
    required this.symbolRight,
    required this.value,
    required this.status,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      symbolLeft: json['symbol_left'] ?? '',
      symbolRight: json['symbol_right'] ?? '',
      value: json['value']?.toString() ?? '1.00',
      status: HomeResponse._toInt(json['status']),
    );
  }
}
