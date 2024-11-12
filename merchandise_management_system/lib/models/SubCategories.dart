import 'ProductCategory.dart';

class SubCategories {
  final int id;
  final String name;
  final ProductCategory productCategory;

  // Default constructor
  SubCategories({
    required this.id,
    required this.name,
    required this.productCategory,
  });

  // Convert SubCategories to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'productCategory': productCategory.toJson(),
  };

  // Create SubCategories from JSON
  factory SubCategories.fromJson(Map<String, dynamic> json) {
    return SubCategories(
      id: json['id'],
      name: json['name'],
      productCategory: ProductCategory.fromJson(json['productCategory']),
    );
  }
}


