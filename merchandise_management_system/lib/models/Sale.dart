import 'package:merchandise_management_system/models/Customer.dart';
import 'package:merchandise_management_system/models/Product.dart';

class Sale {
  int? id;
  Product? product;
  int? quantity;
  double? totalPrice;
  Customer? customer;
  DateTime? saleDate;
  double? price;

  Sale({
    this.id,
    this.product,
    this.quantity,
    this.totalPrice,
    this.customer,
    this.saleDate,
    this.price,

  });

  // Factory constructor for parsing JSON
  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      id: json['id'] as int?,
      product: json['product'] != null
          ? Product.fromJson(json['product'] as Map<String, dynamic>)
          : null,
      quantity: json['quantity'] as int?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      customer: json['customer'] != null
          ? Customer.fromJson(json['customer'] as Map<String, dynamic>)
          : null,
      saleDate: json['saleDate'] != null
          ? DateTime.parse(json['saleDate'] as String)
          : null,
      price: (json['price'] as num?)?.toDouble(),

    );
  }

  // Method to serialize object to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['quantity'] = quantity;
    data['totalPrice'] = totalPrice;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['saleDate'] = saleDate?.toIso8601String();
    data['price'] = price;
    return data;
  }
}
