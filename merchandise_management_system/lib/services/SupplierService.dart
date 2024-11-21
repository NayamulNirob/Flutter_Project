import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:merchandise_management_system/models/Supplier.dart';


class SupplierService {
  final String baseUrl = 'http://localhost:8089/api/supplier';

  // Fetch all suppliers
  Future<List<Supplier>> fetchSuppliers() async {
    final response = await http.get(Uri.parse('$baseUrl/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Supplier.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load suppliers');
    }
  }

  // Add a new supplier
  Future<Supplier> addSupplier(Supplier supplier) async {
    final response = await http.post(
      Uri.parse('$baseUrl/save'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(supplier.toJson()),
    );

    if (response.statusCode == 201) {
      return Supplier.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add supplier');
    }
  }

  // Update an existing supplier
  Future<void> updateSupplier(Supplier supplier) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update/${supplier.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(supplier.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update supplier');
    }
  }

  // Delete a supplier
  Future<void> deleteSupplier(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete supplier');
    }
  }
}
