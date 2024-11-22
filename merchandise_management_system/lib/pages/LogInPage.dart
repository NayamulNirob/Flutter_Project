import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merchandise_management_system/pages/RegistrationPage.dart';
import 'package:merchandise_management_system/pages/User_page.dart';
import 'package:merchandise_management_system/pages/admin_page.dart';
import 'package:merchandise_management_system/services/AuthService.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final store = const FlutterSecureStorage();
  AuthService authService = AuthService();

  LoginPage({super.key});

  Future<void> loginUser(BuildContext context) async {
    try {
      final response = await authService.login(email.text, password.text);
      final role = await authService.getUserRole();
      print(role);

      if (role == 'ADMIN') {
        // Show success message for login
        _showSnackBar(context, 'Login Successful! Redirecting to Admin Page...', Colors.green);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminPage()),
        );
      } else if (role == 'USER') {
        // Show success message for login
        _showSnackBar(context, 'Login Successful! Redirecting to User Page...', Colors.green);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UserPage()),
        );
      } else {
        // Show error message for unknown role
        _showSnackBar(context, 'Unknown role Check password and user name: $role', Colors.red);
      }
    } catch (error) {
      print('Login failed: $error');
      // Show error message for login failure
      _showSnackBar(context, 'Login failed: $error', Colors.red);
    }
  }

  // Helper function to show SnackBar messages
  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: Duration(seconds: 3), // Duration for the SnackBar to stay visible
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4B79A1), Color(0xFF283E51)], // Darker gradient for depth
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Merchandise Management System',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          spreadRadius: 4,
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/mms_logo.png', // Path to your image
                      height: 300,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Welcome Back!',
                    style: GoogleFonts.lato(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildTextField(
                    controller: email,
                    label: 'Email',
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: password,
                    label: 'Password',
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      String em = email.text;
                      String pass = password.text;
                      loginUser(context); // Attempt login
                      print('Email: $em, Password: $pass');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      shadowColor: Colors.blue.withOpacity(0.3),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: GoogleFonts.lato().fontFamily,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegistrationPage()),
                      );
                    },
                    child: const Text(
                      "Don't have an account? Register here",
                      style: TextStyle(
                        color: Colors.white70,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.white),
        ),
        prefixIcon: Icon(icon, color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
