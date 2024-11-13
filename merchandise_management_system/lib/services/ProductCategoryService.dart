import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merchandise_management_system/models/ProductCategory.dart';
import 'package:merchandise_management_system/services/AuthService.dart';
import 'package:http/http.dart' as http;

class ProductCategoryService{
  
  final Dio _dio =Dio();
  
  final AuthService authService =AuthService();
  
  final String baseUrl='http://localhost:8089/api';
  
  
  Future<List<ProductCategory>>fetchProductCategories() async {
    final response =await http.get(Uri.parse('$baseUrl/category/'));
    print(response.statusCode);

    if (response.statusCode==200 ||response.statusCode==201 ){
      List<dynamic>jsonData=jsonDecode(response.body);
      for(var json in jsonData){
        print('Fetched product data: $json');
      }
      return jsonData.map((json)=>ProductCategory.fromJson(json)).toList();
    }else{
      throw Exception('Failed to load Product Categories');
    }
  }

  Future<ProductCategory>getProductCategoriesById(int id) async {
    final response =await http.get(Uri.parse('$baseUrl/category/$id'));

    if(response.statusCode==200||response.statusCode==201){
      return ProductCategory.fromJson(jsonDecode(response.body));

    }else{
      throw Exception('Category not found');
    }
  }

  Future<ProductCategory?>saveCategory(ProductCategory productCategory, XFile? imageFile)async{
    final formData= FormData();

    formData.fields.add(MapEntry('productCategory', jsonEncode(productCategory.toJson())));

    if (imageFile != null) {
      final bytes = await imageFile.readAsBytes();
      formData.files.add(
        MapEntry(
          'imageFile',
          MultipartFile.fromBytes(
            bytes,
            filename: imageFile.name,
            contentType: MediaType('image', 'jpeg'), // Specify content type
          ),
        ),
      );
    }

    final token = await authService.getToken();
    final headers = {
      'Authorization': 'Bearer $token',
      // No need to manually set Content-Type as `Dio` handles it
    };

    try {
      final response = await _dio.post(
        '$baseUrl/category/save',
        data: formData,
        // options: Options(headers: headers), // Set headers here
      );

      if (response.statusCode == 200||response.statusCode==201) {
        final data = response.data as Map<String, dynamic>;
        return ProductCategory.fromJson(data); // Parse response data to Product object
      } else {
        print('Error creating productCategory: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      print('Error creating productCategory: ${e.message}');
      return null;
    }

  }

  Future<void> updateProductCategory(ProductCategory productCategory, int id) async {
    final response = await http.put(
      Uri.parse('$baseUrl/category/update/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(productCategory.toJson()),
    );

    if (response.statusCode != 200 || response.statusCode != 201) {
      throw Exception('Failed to update product');
    }
  }

  Future<void> deleteProductCategory(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/category/delete/$id'));

    if (response.statusCode != 200 || response.statusCode != 201) {
      throw Exception('Failed to delete productCategory');
    }
  }

  
}