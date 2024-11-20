import 'dart:math';

import 'package:merchandise_management_system/models/SubCategories.dart';

class ProductCategory {
  final int id;
  final String categoryCode;
  final String name;
  final String description;
  final String image;
  final List<SubCategories> subCategories;

  static const String _characters = '0123ABCDEFG';
  static const int _codeLength = 4;
  static final Random _random = Random.secure();

  // Default constructor
  ProductCategory({
    required this.id,
    String? categoryCode, // optional as it's auto-generated
    required this.name,
    required this.description,
    required this.image,
    this.subCategories = const [],
  }) : categoryCode = categoryCode ?? _generateCategoryCode();

  // Generates a random category code
  static String _generateCategoryCode() {
    return List.generate(
      _codeLength,
          (index) => _characters[_random.nextInt(_characters.length)],
    ).join();
  }

  // Convert ProductCategory to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'categoryCode': categoryCode,
    'name': name,
    'description': description,
    'image': image,
    'subCategories': subCategories.map((subCat) => subCat.toJson()).toList(),
  };

  // Create ProductCategory from JSON
  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'],
      categoryCode: json['categoryCode'] ?? _generateCategoryCode(),
      name: json['name'],
      description: json['description'],
      image: json['image'],
      subCategories: (json['subCategories'] as List<dynamic>?)
          ?.map((subCatJson) => SubCategories.fromJson(subCatJson))
          .toList() ??
          [],
    );
  }
}
