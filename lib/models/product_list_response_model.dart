class ProductListResponse {
  final int success;
  final String message;
  final List<ProductListItem> products;
  final PaginationData? pagination;
  final FilterData? filters;

  ProductListResponse({
    required this.success,
    required this.message,
    required this.products,
    this.pagination,
    this.filters,
  });

  factory ProductListResponse.fromJson(Map<String, dynamic> json) {
    return ProductListResponse(
      success: json['success'] ?? 0,
      message: json['message'] ?? '',
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => ProductListItem.fromJson(e))
              .toList() ??
          [],
      pagination: json['pagination'] != null
          ? PaginationData.fromJson(json['pagination'])
          : null,
      filters: json['filters'] != null
          ? FilterData.fromJson(json['filters'])
          : null,
    );
  }

  bool get isSuccess => success == 1;
}

class ProductListItem {
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
  final String? description;
  final int? stock;
  final double? rating;

  ProductListItem({
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
    this.description,
    this.stock,
    this.rating,
  });

  factory ProductListItem.fromJson(Map<String, dynamic> json) {
    return ProductListItem(
      slug: json['slug'] ?? '',
      name: json['name'] ?? '',
      store: json['store'] ?? '',
      manufacturer: json['manufacturer'] ?? '',
      symbolLeft: json['symbol_left'] ?? '',
      symbolRight: json['symbol_right'] ?? '',
      oldPrice: json['oldprice'] ?? '0',
      price: json['price'] ?? '0',
      discount: json['discount'] ?? '0',
      image: json['image'] ?? '',
      description: json['description'],
      stock: json['stock'],
      rating: json['rating']?.toDouble(),
    );
  }

  double get priceValue => double.tryParse(price) ?? 0.0;
  double get oldPriceValue => double.tryParse(oldPrice) ?? 0.0;

  int get discountPercentage {
    if (oldPriceValue == 0) return 0;
    final discountAmount = oldPriceValue - priceValue;
    if (discountAmount <= 0) return 0;
    return ((discountAmount / oldPriceValue) * 100).round();
  }
}

class PaginationData {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final bool hasMorePages;

  PaginationData({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.hasMorePages,
  });

  factory PaginationData.fromJson(Map<String, dynamic> json) {
    return PaginationData(
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
      perPage: json['per_page'] ?? 20,
      total: json['total'] ?? 0,
      hasMorePages: json['has_more_pages'] ?? false,
    );
  }
}

class FilterData {
  final List<FilterOption>? brands;
  final List<FilterOption>? categories;
  final List<FilterOption>? sizes;
  final List<FilterOption>? colors;
  final PriceRange? priceRange;

  FilterData({
    this.brands,
    this.categories,
    this.sizes,
    this.colors,
    this.priceRange,
  });

  factory FilterData.fromJson(Map<String, dynamic> json) {
    return FilterData(
      brands: (json['brands'] as List<dynamic>?)
          ?.map((e) => FilterOption.fromJson(e))
          .toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => FilterOption.fromJson(e))
          .toList(),
      sizes: (json['sizes'] as List<dynamic>?)
          ?.map((e) => FilterOption.fromJson(e))
          .toList(),
      colors: (json['colors'] as List<dynamic>?)
          ?.map((e) => FilterOption.fromJson(e))
          .toList(),
      priceRange: json['price_range'] != null
          ? PriceRange.fromJson(json['price_range'])
          : null,
    );
  }
}

class FilterOption {
  final String id;
  final String name;
  final int count;

  FilterOption({
    required this.id,
    required this.name,
    required this.count,
  });

  factory FilterOption.fromJson(Map<String, dynamic> json) {
    return FilterOption(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      count: json['count'] ?? 0,
    );
  }
}

class PriceRange {
  final double min;
  final double max;

  PriceRange({
    required this.min,
    required this.max,
  });

  factory PriceRange.fromJson(Map<String, dynamic> json) {
    return PriceRange(
      min: (json['min'] ?? 0).toDouble(),
      max: (json['max'] ?? 0).toDouble(),
    );
  }
}
