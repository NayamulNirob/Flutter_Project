import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:merchandise_management_system/models/Stock.dart';

class StockService {
  final String baseUrl='http://localhost:8089/api/stock';


  /// Fetch all stocks
  Future<List<Stock>> getStocks() async {
    final response = await http.get(Uri.parse('$baseUrl/'));

    if (response.statusCode == 200) {
      final List<dynamic> stockJson = json.decode(response.body);
      return stockJson.map((json) => Stock.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch stocks: ${response.body}');
    }
  }

  /// Fetch a single stock by ID
  Future<Stock> getStockById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> stockJson = json.decode(response.body);
      return Stock.fromJson(stockJson);
    } else {
      throw Exception('Failed to fetch stock: ${response.body}');
    }
  }

  /// Create a new stock
  Future<Stock> createStock(Stock stock) async {
    final response = await http.post(
      Uri.parse('$baseUrl/save'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(stock.toJson()),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> stockJson = json.decode(response.body);
      return Stock.fromJson(stockJson);
    } else {
      throw Exception('Failed to create stock: ${response.body}');
    }
  }

  /// Update an existing stock
  Future<Stock> updateStock(int id, Stock stock) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(stock.toJson()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> stockJson = json.decode(response.body);
      return Stock.fromJson(stockJson);
    } else {
      throw Exception('Failed to update stock: ${response.body}');
    }
  }

  /// Delete a stock by ID
  Future<void> deleteStock(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete stock: ${response.body}');
    }
  }
}
