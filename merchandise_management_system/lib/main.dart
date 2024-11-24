import 'package:flutter/material.dart';
import 'package:merchandise_management_system/pages/LogInPage.dart';
import 'package:merchandise_management_system/pages/UserProfilePage.dart';
import 'package:merchandise_management_system/pages/User_page.dart';
import 'package:merchandise_management_system/pages/admin_page.dart'; // Assuming this exists

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Merchandise Management System',
      routes: {
        '/login': (context) => LoginPage(),
        // '/profile': (context) => UserProfileView(), // Adjust the name if necessary
        '/adminPage': (context) => AdminPage(),
        '/userpage':(context)=>UserPage(),
      },
      initialRoute: '/login', // Start at the login page
      home: LoginPage(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

