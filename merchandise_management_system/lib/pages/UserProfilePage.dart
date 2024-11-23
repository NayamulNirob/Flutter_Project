import 'package:flutter/material.dart';

import 'package:merchandise_management_system/models/User.dart';
import 'package:merchandise_management_system/services/AuthService.dart';

class UserProfileView extends StatefulWidget {
  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  User? _currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  Future<void> _fetchCurrentUser() async {
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
          ? Center(child: Text('No user data available'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [

            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _currentUser?.image != null && _currentUser!.image!.isNotEmpty
                    ? NetworkImage("http://localhost:8089/images/${_currentUser!.image!}")
                    : AssetImage('assets/default_avatar.png') as ImageProvider,
                onBackgroundImageError: (error, stackTrace) {
                  debugPrint("Failed to load image: $error");
                },
              ),
            ),

            // User Details
            _buildProfileField('Name', _currentUser!.name),
            _buildProfileField('Email', _currentUser!.email),
            _buildProfileField('Phone', _currentUser!.cell),
            _buildProfileField('Address', _currentUser!.address),
            _buildProfileField('Date of Birth', _currentUser!.dob),
            _buildProfileField('Gender', _currentUser!.gender),
            _buildProfileField('Role', _currentUser!.role),
            _buildProfileField('Username', _currentUser!.username),

            SizedBox(height: 30),

            // Logout Button
            ElevatedButton(
              onPressed: () async {
                AuthService authService = AuthService();
                await authService.logout();
                Navigator.of(context).pushReplacementNamed('/login');
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
