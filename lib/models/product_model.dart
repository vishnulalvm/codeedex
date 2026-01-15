class ProductModel {
  final String id;
  final String name;
  final String category;
  final double originalPrice;
  final double discountedPrice;
  final String weight;
  final String image;
  final bool isFavorite;
  final String? slug;
  final String? store;
  final String? manufacturer;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.originalPrice,
    required this.discountedPrice,
    required this.weight,
    required this.image,
    this.isFavorite = false,
    this.slug,
    this.store,
    this.manufacturer,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['slug'] ?? json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      category: json['manufacturer'] ?? json['store'] ?? '',
      originalPrice: double.tryParse(json['oldprice']?.toString() ?? '0') ?? 0.0,
      discountedPrice: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      weight: '',
      image: json['image'] ?? '',
      slug: json['slug'],
      store: json['store'],
      manufacturer: json['manufacturer'],
    );
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? category,
    double? originalPrice,
    double? discountedPrice,
    String? weight,
    String? image,
    bool? isFavorite,
    String? slug,
    String? store,
    String? manufacturer,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      originalPrice: originalPrice ?? this.originalPrice,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      weight: weight ?? this.weight,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
      slug: slug ?? this.slug,
      store: store ?? this.store,
      manufacturer: manufacturer ?? this.manufacturer,
    );
  }
}
