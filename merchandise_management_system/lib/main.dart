import 'package:flutter/material.dart';
import 'package:merchandise_management_system/pages/LogInPage.dart';
import 'package:merchandise_management_system/pages/UserProfilePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Merchandise Management System',
      routes: {
        '/login': (context) => LoginPage(),
        '/profile': (context) => UserProfileView(),
      },
      initialRoute: '/login',
      // Set the initial route to LoginPage
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // home: LoginPage(),
      ),
    );
  }
}
