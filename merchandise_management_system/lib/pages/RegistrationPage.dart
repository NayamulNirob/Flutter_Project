import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:intl/intl.dart';
import 'package:merchandise_management_system/pages/LogInPage.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});


  @override
  State<RegistrationPage> createState() => _RegistrationPageState();


}

class _RegistrationPageState extends State<RegistrationPage> {

  final TextEditingController name = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController confirmPassword = TextEditingController();

  final TextEditingController cell = TextEditingController();

  final TextEditingController address = TextEditingController();

  final TextEditingController dob = TextEditingController()
    ..text = DateFormat('yyyy-MM-dd').format(DateTime.now());

  final RadioGroupController genderController = RadioGroupController();

  String? selectedGender;

  DateTime? selectedDate;

  XFile? selectedImage;

  Uint8List? webImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    if (kIsWeb) {
      // For Web: Use image_picker_web to pick image and store as bytes
      var pickedImage = await ImagePickerWeb.getImageAsBytes();
      if (pickedImage != null) {
        setState(() {
          webImage = pickedImage; // Store the picked image as Uint8List
        });
      }
    } else {
      // For Mobile: Use image_picker to pick image
      final XFile? pickedImage =
      await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          selectedImage = pickedImage;
        });
      }
    }
  }

  Future<bool> submitRegistration() async {
    final user = {
      'gender': genderController.value,
      'name': name.text,
      'email': email.text,
      'password': password.text,
      'cell': cell.text,
      'address': address.text,
      'dob': dob.text,
    };

    var uri = Uri.parse('http://localhost:8089/register');
    var request = http.MultipartRequest('POST', uri);


    request.files.add(
      http.MultipartFile.fromString(
        'user',
        jsonEncode(user),
        contentType: MediaType('application', 'json'),
      ),
    );

    if (kIsWeb && webImage != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        webImage!,
        filename: 'upload.jpg',
        contentType: MediaType('image', 'jpeg'),
      ));
    } else if (selectedImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        selectedImage!.path,
      ));
    }


    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
        print('Registration successful');
        return true;
      } else {
        print('Failed to register. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error occurred while submitting: $e');
      return false;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/reg_back.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),  // Adds a dark overlay
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Card(
                color: Colors.white.withOpacity(0.9),  // Slightly transparent card
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Center(
                        child: Text(
                          "Create Your Account",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      buildTextField(controller: name, label: "Name", icon: Icons.person),
                      buildTextField(controller: email, label: "Email", icon: Icons.email),
                      buildTextField(controller: password, label: "Password", icon: Icons.lock, obscureText: true),
                      buildTextField(controller: confirmPassword, label: "Confirm Password", icon: Icons.lock, obscureText: true),
                      buildTextField(controller: cell, label: "Cell Number", icon: Icons.phone),
                      buildTextField(controller: address, label: "Address", icon: Icons.location_city),
                      buildDateField(),
                      const SizedBox(height: 10),
                      const Text("Gender", style: TextStyle(fontSize: 16, color: Colors.blueAccent)),
                      RadioGroup(
                        controller: genderController,
                        values: const ["Male", "Female", "Others"],
                        indexOfDefault: 0,
                        orientation: RadioGroupOrientation.horizontal,
                        decoration: const RadioGroupDecoration(
                          spacing: 20.0,
                          activeColor: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.image),
                        label: const Text('Upload Profile Picture'),
                        onPressed: pickImage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () async {
                          bool isRegistered = await submitRegistration();
                          if (isRegistered) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Registration failed. Please try again.')),
                            );
                          }
                        },
                        child: const Text('Register', style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.8),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          labelStyle: const TextStyle(color: Colors.blueGrey),
        ),
      ),
    );
  }

  Widget buildDateField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2101),
          );
          if (picked != null && picked != selectedDate) {
            setState(() {
              selectedDate = picked;
              dob.text = DateFormat('yyyy-MM-dd').format(selectedDate!);
            });
          }
        },
        controller: dob,
        readOnly: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.8),
          labelText: "Date of Birth",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Icon(Icons.calendar_today, color: Colors.blueAccent),
          labelStyle: const TextStyle(color: Colors.blueGrey),
        ),
      ),
    );
  }


}