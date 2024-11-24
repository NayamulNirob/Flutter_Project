import 'package:merchandise_management_system/models/Customer.dart';
import 'package:merchandise_management_system/models/Product.dart';

class OrderItem {
  int? id;
  Customer? customer;
  Product? product;
  int? quantity;
  String? status;
  DateTime? orderDate;
  DateTime? deliveryDate;
  double? totalPrice;


  OrderItem(
      {this.id,
        this.customer,
        this.product,
        this.quantity,
        this.status,
        this.orderDate,
        this.deliveryDate,
        this.totalPrice});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    status = json['status'];
    orderDate = json['orderDate'] != null
        ? DateTime.parse(json['orderDate']) // Parse string to DateTime
        : null;
    deliveryDate = json['deliveryDate'] != null
        ? DateTime.parse(json['deliveryDate']) // Parse string to DateTime
        : null;
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity'] = this.quantity;
    data['status'] = this.status;
    data['orderDate'] = this.orderDate?.toIso8601String();
    data['deliveryDate'] = this.deliveryDate?.toIso8601String();
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}


