import 'package:merchandise_management_system/models/Product.dart';

import 'ProductCategory.dart';

class SubCategories {
  final int id;
  final String name;
  final List<Product> products;
  final ProductCategory productCategory;

  // Default constructor
  SubCategories({
    required this.id,
    required this.name,
    required this.productCategory,
    this.products = const [],
  });

  // Convert SubCategories to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'products': products.map((prod) => prod.toJson()).toList(),
    'productCategory': productCategory.toJson(),
  };

  // Create SubCategories from JSON
  factory SubCategories.fromJson(Map<String, dynamic> json) {
    return SubCategories(
      id: json['id'],
      name: json['name'],
      productCategory: ProductCategory.fromJson(json['productCategory']),
      products: (json['products'] as List<dynamic>?)
          ?.map((prodJson) => Product.fromJson(prodJson))
          .toList() ??
          [],
    );
  }
}


