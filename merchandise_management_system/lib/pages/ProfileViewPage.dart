import 'package:flutter/material.dart';
import 'package:merchandise_management_system/services/AuthService.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserViewPage extends StatefulWidget {
  final int userId; // Pass the user ID to this page

  UserViewPage({required this.userId});

  @override
  _UserViewPageState createState() => _UserViewPageState();
}

class _UserViewPageState extends State<UserViewPage> {
  Map<String, dynamic>? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      String? token = await AuthService().getToken();
      if (token == null) throw Exception("No token found");

      final response = await http.get(
        Uri.parse('http://localhost:8089/users/${widget.userId}'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        setState(() {
          user = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch user data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : user != null
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: user!['image'] != null
                  ? NetworkImage(
                  'http://localhost:8089/uploads/${user!['image']}')
                  : null,
              child: user!['image'] == null
                  ? Icon(Icons.person, size: 40)
                  : null,
            ),
            SizedBox(height: 20),
            Text('Name: ${user!['name']}', style: TextStyle(fontSize: 18)),
            Text('Email: ${user!['email']}', style: TextStyle(fontSize: 18)),
            Text('Cell: ${user!['cell']}', style: TextStyle(fontSize: 18)),
            Text('Address: ${user!['address']}', style: TextStyle(fontSize: 18)),
            Text('DOB: ${user!['dob']}', style: TextStyle(fontSize: 18)),
            Text('Gender: ${user!['gender']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality to edit user if needed
              },
              child: Text('Edit'),
            ),
          ],
        ),
      )
          : Center(child: Text('User not found')),
    );
  }
}
