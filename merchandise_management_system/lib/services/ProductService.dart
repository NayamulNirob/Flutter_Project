import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:merchandise_management_system/models/Product.dart';
import 'package:merchandise_management_system/models/SubCategories.dart';
import 'package:merchandise_management_system/models/Supplier.dart';
import 'package:merchandise_management_system/services/AuthService.dart';
import 'package:image_picker/image_picker.dart';


class ProductService {

  final Dio _dio=Dio();

  final AuthService authService =AuthService();

  final String baseUrl='http://localhost:8089/api';


  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/product/'));
    print(response.statusCode);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      for (var json in jsonData) {
        // print('Fetched product data: $json');
      }
      return jsonData.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Product> getProductById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/product/$id'));

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Product not found');
    }
  }

  Future<Product?> saveProduct(Product product, XFile? imageFile) async {
    final formData = FormData();

    // Add product data as JSON string
    formData.fields.add(MapEntry('product', jsonEncode(product.toJson())));

    // Add image if present, with explicit content type
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
        '$baseUrl/product/save',
        data: formData,
        // options: Options(headers: headers), // Set headers here
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return Product.fromJson(data); // Parse response data to Product object
      } else {
        print('Error creating product: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      print('Error creating product: ${e.message}');
      return null;
    }
  }


  Future<void> updateProduct(Product product, int id) async {
    final response = await http.put(
      Uri.parse('$baseUrl/product/update/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update product');
    }
  }

  Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/product/delete/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }

  Future<List<Supplier>> fetchSuppliers() async {
    final response = await http.get(Uri.parse('$baseUrl/supplier/'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Supplier.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load suppliers');
    }
  }

  Future<List<SubCategories>> fetchSubCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/subcategories/'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => SubCategories.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load subcategories');
    }
  }
}
