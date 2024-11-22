import 'package:flutter/material.dart';
import 'package:merchandise_management_system/pages/LogInPage.dart';
import 'package:merchandise_management_system/services/AuthService.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Hello User',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Logout logic
          await AuthService().logout();
          // Navigate to the login page after logout
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.logout), // Icon for logout action
      ),
    );
  }
}
