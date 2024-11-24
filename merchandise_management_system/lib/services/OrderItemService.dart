import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:merchandise_management_system/models/OrderItem.dart';

class OrderItemService {
  final String baseUrl = 'http://localhost:8089/api/order'; // Replace with your actual API URL

  // Fetch all order items
  Future<List<OrderItem>> fetchOrderItems() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => OrderItem.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load order items');
      }
    } catch (e) {
      throw Exception('Error fetching order items: $e');
    }
  }

  // Fetch a single order item by ID
  Future<OrderItem> fetchOrderItemById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));
      if (response.statusCode == 200 || response.statusCode == 200) {
        return OrderItem.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load order item');
      }
    } catch (e) {
      throw Exception('Error fetching order item: $e');
    }
  }

  // Create a new order item
  Future<OrderItem> createOrderItem(OrderItem orderItem) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/save'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(orderItem.toJson()),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return OrderItem.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create order item');
      }
    } catch (e) {
      throw Exception('Error creating order item: $e');
    }
  }

  // Update an existing order item
  Future<OrderItem> updateOrderItem(int id, OrderItem orderItem) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/update/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(orderItem.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 200) {
        return OrderItem.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update order item');
      }
    } catch (e) {
      throw Exception('Error updating order item: $e');
    }
  }

  // Delete an order item by ID
  Future<void> deleteOrderItem(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));
      if (response.statusCode != 200 || response.statusCode != 201) {
        throw Exception('Failed to delete order item');
      }
    } catch (e) {
      throw Exception('Error deleting order item: $e');
    }
  }
}
