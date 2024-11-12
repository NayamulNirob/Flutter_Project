import 'package:intl/intl.dart';

import 'Country.dart';

class Supplier {
  final int id;
  final String name;
  final String? contactPerson;
  final String? email;
  final String? phone;
  final String? address;
  DateTime createdAt;
  DateTime updatedAt;
  String? status;
  String? organization;
  Country country;

  Supplier({
    required this.id,
    required this.name,
    this.contactPerson,
    this.email,
    this.phone,
    this.address,
    required this.createdAt,
    required this.updatedAt,
    this.status,
    this.organization,
    required this.country,
  });

  // Convert the Supplier to a JSON map for serialization
  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'contactPerson': contactPerson,
        'email': email,
        'phone': phone,
        'address': address,
        'createdAt': DateFormat('yyyy-MM-ddTHH:mm:ss').format(createdAt),
        'updatedAt': DateFormat('yyyy-MM-ddTHH:mm:ss').format(updatedAt),
        'status': status,
        'organization': organization,
        'country': country.toJson(),
      };

  // Create a Supplier from a JSON map
  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['id'],
      name: json['name'],
      contactPerson: json['contactPerson'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      status: json['status'],
      organization: json['organization'],
      country: Country.fromJson(json['country']),
    );
  }

}
