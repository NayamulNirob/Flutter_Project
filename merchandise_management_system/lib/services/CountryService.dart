import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:merchandise_management_system/models/Country.dart';
import 'package:merchandise_management_system/services/AuthService.dart';
import 'package:image_picker/image_picker.dart';


class CountryService {

  final Dio _dio=Dio();

  final AuthService authService =AuthService();

  final String baseUrl='http://localhost:8089/api';


  Future<List<Country>> fetchCountries() async {
    final response = await http.get(Uri.parse('$baseUrl/country/'));
    print(response.statusCode);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      for (var json in jsonData) {
        // print('Fetched Country data: $json');
      }
      return jsonData.map((json) => Country.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Countries');
    }
  }

  Future<Country> getCountryById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/country/$id'));

    if (response.statusCode == 200) {
      return Country.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Country not found');
    }
  }

  Future<Country?> saveCountry(Country Country, XFile? imageFile) async {
    final formData = FormData();

    // Add Country data as JSON string
    formData.fields.add(MapEntry('country', jsonEncode(Country.toJson())));

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
        '$baseUrl/country/save',
        data: formData,
        // options: Options(headers: headers), // Set headers here
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return Country; // Parse response data to Country object
      } else {
        print('Error creating Country: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      print('Error creating Country: ${e.message}');
      return null;
    }
  }


  Future<void> updateCountry(Country Country, int id) async {
    final response = await http.put(
      Uri.parse('$baseUrl/country/update/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(Country.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update Country');
    }
  }

  Future<void> deleteCountry(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/country/delete/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete Country');
    }
  }

  
}
