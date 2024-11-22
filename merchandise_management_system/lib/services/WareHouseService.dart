import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:merchandise_management_system/models/WareHouse.dart';

class WarehouseService{
  final String baseUrl = 'http://localhost:8089/api/warehouse';

  // Fetch all WareHouse
  Future<List<WareHouse>> fetchWareHouses() async {
    final response = await http.get(Uri.parse('$baseUrl/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => WareHouse.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load WareHouse');
    }
  }

  // Add a new supplier
  Future<WareHouse> addWareHouse(WareHouse wareHouse) async {
    final response = await http.post(
      Uri.parse('$baseUrl/save'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(wareHouse.toJson()),
    );

    if (response.statusCode == 201) {
      return WareHouse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add WareHouse');

    }
  }

  // Update an existing WareHouse
  Future<void> updateWareHouse(WareHouse wareHouse) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update/${wareHouse.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(wareHouse.toJson()),
    );

    if (response.statusCode != 200) {
      print('Error: ${response.body}');
      throw Exception('Failed to update WareHouse');
    }
  }

  // Delete a supplier
  Future<void> deleteWareHouse(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));

    if (response.statusCode != 204) {
      print('Error: ${response.body}');
      throw Exception('Failed to delete WareHouse');
    }
  }

}