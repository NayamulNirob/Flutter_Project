import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:merchandise_management_system/models/Transaction.dart';


class TransactionService {
  final String baseUrl='http://localhost:8089/api/transaction';


  /// Fetch all transactions from the server
  Future<List<Transaction>> fetchTransactions() async {
    final response = await http.get(Uri.parse('$baseUrl/'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Transaction.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  /// Fetch a single transaction by ID
  Future<Transaction> fetchTransactionById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load transaction with ID: $id');
    }
  }

  /// Create a new transaction
  Future<Transaction> createTransaction(Transaction transaction) async {
    final response = await http.post(
      Uri.parse('$baseUrl/save'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(transaction.toJson()),
    );

    if (response.statusCode == 201) {
      return Transaction.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create transaction');
    }
  }

  /// Update an existing transaction
  Future<Transaction> updateTransaction(int id, Transaction transaction) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(transaction.toJson()),
    );

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update transaction with ID: $id');
    }
  }

  /// Delete a transaction by ID
  Future<void> deleteTransaction(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete transaction with ID: $id');
    }
  }
}
