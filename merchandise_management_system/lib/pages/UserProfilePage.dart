import 'package:flutter/material.dart';

import 'package:merchandise_management_system/models/User.dart';
import 'package:merchandise_management_system/services/AuthService.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  User? _currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    AuthService authService = AuthService();
    User? user = await authService.getCurrentUser();
    setState(() {
      _currentUser = user;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _currentUser == null
          ? Center(child: Text('No user data found'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _currentUser!.image != null
                    ? NetworkImage(_currentUser!.image!)
                    : AssetImage('assets/default_avatar.png')
                as ImageProvider,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Name: ${_currentUser!.name ?? "N/A"}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Email: ${_currentUser!.email ?? "N/A"}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Phone: ${_currentUser!.cell ?? "N/A"}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Address: ${_currentUser!.address ?? "N/A"}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Date of Birth: ${_currentUser!.dob ?? "N/A"}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Gender: ${_currentUser!.gender ?? "N/A"}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Role: ${_currentUser!.role ?? "N/A"}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                AuthService authService = AuthService();
                authService.logout().then((_) {
                  Navigator.of(context).pushReplacementNamed('/login');
                });
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
