import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:merchandise_management_system/models/SubCategories.dart';
import 'package:merchandise_management_system/services/AuthService.dart';


class SubCategoriesService {

  final Dio _dio =Dio();

  final AuthService authService =AuthService();

  final String baseUrl='http://localhost:8089/api';// Replace with your backend URL

  // Fetch all subcategories
  Future<List<SubCategories>> fetchSubCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/subcategories/'));
    print(response.statusCode);

    if (response.statusCode == 200 ||response.statusCode==201) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => SubCategories.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load subcategories");
    }
  }

  // Add a new subcategory
  Future<SubCategories> createSubCategory(SubCategories subCategory) async {

    final response = await http.post(
      Uri.parse('$baseUrl/subcategories/save'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(subCategory.toJson()),
    );

    if (response.statusCode == 201) {
      return SubCategories.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to create subcategory");
    }
  }

  // Update an existing subcategory
  Future<SubCategories> updateSubCategory(int id, SubCategories subCategory) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(subCategory.toJson()),
    );

    if (response.statusCode == 200) {
      return SubCategories.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to update subcategory");
    }
  }

  // Delete a subcategory
  Future<void> deleteSubCategory(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));

    if (response.statusCode != 204) {
      throw Exception("Failed to delete subcategory");
    }
  }
}
