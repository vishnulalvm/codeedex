class ProductModel {
  final String id;
  final String name;
  final String category;
  final double originalPrice;
  final double discountedPrice;
  final String weight;
  final String image;
  final bool isFavorite;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.originalPrice,
    required this.discountedPrice,
    required this.weight,
    required this.image,
    this.isFavorite = false,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    String? category,
    double? originalPrice,
    double? discountedPrice,
    String? weight,
    String? image,
    bool? isFavorite,
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
    );
  }
}
