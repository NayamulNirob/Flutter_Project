import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../services/AuthService.dart';

class ProfileViewPage extends StatefulWidget {
  const ProfileViewPage({super.key});
  @override
  _ProfileViewPageState createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {

  final _imagePicker = ImagePicker();
  File? _profileImage;

  final store = const FlutterSecureStorage();
  AuthService authService = AuthService();

  // Example user data
  Map<String, dynamic> user = {
    "name": "John Doe",
    "email": "john.doe@example.com",
    "cell": "123-456-7890",
    "address": "123 Main Street, Cityville",
    "dob": "1990-01-01",
    "gender": "Male",
    "image": null, // Backend will provide the path to the image
    "active": true,
  };

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      // You would then upload the image to the server here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: _profileImage != null
                  ? FileImage(_profileImage!)
                  : user['image'] != null
                  ? NetworkImage(user['image']) as ImageProvider
                  : AssetImage('assets/placeholder.png'),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.blue),
                      onPressed: _pickImage,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.0),
            _buildProfileField("Name", user['name']),
            _buildProfileField("Email", user['email']),
            _buildProfileField("Phone", user['cell']),
            _buildProfileField("Address", user['address']),
            _buildProfileField("Date of Birth", user['dob']),
            _buildProfileField("Gender", user['gender']),
            _buildProfileField("Status", user['active'] ? "Active" : "Inactive"),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Handle user logout or edit
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 4.0),
        Text(
          value,
          style: TextStyle(fontSize: 16.0),
        ),
        Divider(),
      ],
    );
  }
}
