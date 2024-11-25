import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:merchandise_management_system/models/Sale.dart';

class SalesService {
  final String apiUrl = 'http://localhost:8089/api/sale';
  final Map<String, String> headers = {'Content-Type': 'application/json'};

  // Fetch all sales
  Future<List<Sale>> fetchSales() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/')).timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        final List<dynamic> salesJson = json.decode(response.body);
        return salesJson.map((json) => Sale.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load sales. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching sales: $e');
    }
  }

  // Fetch a single sale by ID
  Future<Sale> fetchSaleById(int id) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/$id')).timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        final Map<String, dynamic> saleJson = json.decode(response.body);
        return Sale.fromJson(saleJson);
      } else {
        throw Exception('Failed to load sale with ID $id. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching sale by ID: $e');
    }
  }

  // Create a new sale
  Future<Sale> createSale(Sale sale) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/save'),
        headers: headers,
        body: json.encode(sale.toJson()),
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 201) {
        final Map<String, dynamic> saleJson = json.decode(response.body);
        return Sale.fromJson(saleJson);
      } else {
        throw Exception('Failed to create sale. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error creating sale: $e');
    }
  }

  // Update an existing sale
  Future<Sale> updateSale(Sale sale) async {
    if (sale.id == null) {
      throw Exception('Sale ID is required for updates');
    }

    try {
      final response = await http.put(
        Uri.parse('$apiUrl/update/${sale.id}'),
        headers: headers,
        body: json.encode(sale.toJson()),
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> saleJson = json.decode(response.body);
        return Sale.fromJson(saleJson);
      } else {
        throw Exception('Failed to update sale with ID ${sale.id}. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error updating sale: $e');
    }
  }

  // Delete a sale by ID
  Future<void> deleteSale(int id) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/delete/$id')).timeout(Duration(seconds: 10));
      if (response.statusCode != 200) {
        throw Exception('Failed to delete sale with ID $id. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error deleting sale: $e');
    }
  }
}
