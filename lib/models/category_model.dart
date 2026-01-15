class CategoryModel {
  final String id;
  final String name;
  final String image;
  final String? slug;
  final String? description;
  final int? subcategory;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.slug,
    this.description,
    this.subcategory,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    // Check if this is a category item with nested category object
    if (json.containsKey('category')) {
      final categoryData = json['category'];
      return CategoryModel(
        id: categoryData['id']?.toString() ?? '',
        name: categoryData['name'] ?? '',
        image: categoryData['image'] ?? '',
        slug: categoryData['slug'],
        description: categoryData['description'],
        subcategory: json['subcategory'],
      );
    }

    // Direct category object
    return CategoryModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      slug: json['slug'],
      description: json['description'],
    );
  }
}
