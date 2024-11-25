import 'package:merchandise_management_system/models/Product.dart';
import 'package:merchandise_management_system/models/ProductCategory.dart';
import 'package:merchandise_management_system/models/WareHouse.dart';

class Stock {
  int? id;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  ProductCategory? categoryName;
  Product? product;
  WareHouse? wareHouse;

  Stock({
    this.id,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.categoryName,
    this.product,
    this.wareHouse,
  });

  Stock.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    categoryName = json['categoryName'] != null
        ? ProductCategory.fromJson(json['categoryName'])
        : null; // Ensure consistent naming
    product = json['product'] != null
        ? Product.fromJson(json['product'])
        : null;
    wareHouse = json['wareHouse'] != null
        ? WareHouse.fromJson(json['wareHouse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['quantity'] = quantity;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (categoryName != null) {
      data['categoryName'] = categoryName!.toJson();
    }
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (wareHouse != null) {
      data['wareHouse'] = wareHouse!.toJson();
    }
    return data;
  }
}
