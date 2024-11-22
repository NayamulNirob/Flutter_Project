import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:merchandise_management_system/models/Customer.dart';

class CustomerService {
  final String baseUrl = 'http://localhost:8089/api/customer';

  Future<List<Customer>> fetchCustomers() async {
    final response = await http.get(Uri.parse('$baseUrl/'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Customer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Customers');
    }
  }

  Future<Customer> addCustomer(Customer customer) async {
    final response = await http.post(
      Uri.parse('$baseUrl/save'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(customer.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Customer.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed toa add Customer');
    }
  }

  // Update an existing Customer
  Future<void> updateCustomer(Customer customer) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update/${customer.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(customer.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
      // Successfully updated the customer, no need to throw an exception.
      // You can reload the data here if needed
      print('Customer updated successfully');
    } else {
      // If status code is not 200/201/204, throw an exception
      throw Exception('Failed to update Customer');
    }

  }

  // Delete a Customer
  Future<void> deleteCustomer(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
      // Successfully updated the customer, no need to throw an exception.
      // You can reload the data here if needed
      print('Customer deleted successfully');
    } else {
      // If status code is not 200/201/204, throw an exception
      throw Exception('Failed to deleted Customer');
    }
  }
}
