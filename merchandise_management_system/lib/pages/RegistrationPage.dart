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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Registration",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: name,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
                icon: Icon(Icons.person),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                icon: Icon(Icons.email),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                icon: Icon(Icons.password),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: confirmPassword,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
                icon: Icon(Icons.password),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: cell,
              decoration: const InputDecoration(
                labelText: "Cell Number",
                border: OutlineInputBorder(),
                icon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: address,
              decoration: const InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(),
                icon: Icon(Icons.location_city),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
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
                    String formattedDate =
                    DateFormat('yyyy-MM-dd').format(selectedDate!);
                    dob.text = formattedDate;
                  });
                }
              },
              controller: dob,
              decoration: const InputDecoration(
                labelText: "Date of Birth",
                border: OutlineInputBorder(),
                icon: Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Gender"),
            const SizedBox(
              height: 10,
            ),
            RadioGroup(
              controller: genderController,
              values: const ["Male", "Female", "Others"],
              indexOfDefault: 0,
              orientation: RadioGroupOrientation.horizontal,
              decoration: RadioGroupDecoration(
                spacing: 10.0,
                labelStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                activeColor: Colors.blue,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.image),
              label: const Text('Pick Image'),
              onPressed: pickImage,
            ),
            const SizedBox(
              height: 10,
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () async {
                bool isRegistered = await submitRegistration();
                if (isRegistered) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Loginpage()),
                  );
                } else {
                  // Show an error message or handle unsuccessful registration as needed.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Registration failed. Please try again.')),
                  );
                }
              },
              child: const Text(
                'Registration',
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }

}