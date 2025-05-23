import 'package:flutter/material.dart';
import 'package:merchandise_management_system/models/User.dart';
import 'package:merchandise_management_system/services/AuthService.dart';

class UserProfileView extends StatefulWidget {
  final VoidCallback? onProfileClosed; // Optional callback function

  const UserProfileView({super.key, this.onProfileClosed});

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('User Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            // Trigger callback before popping
            widget.onProfileClosed?.call();
            Navigator.pop(context); // Go back to the previous page
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _currentUser == null
            ? const Center(
          child: Text(
            'No user data available',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 100),
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _currentUser?.image != null &&
                    _currentUser!.image!.isNotEmpty
                    ? NetworkImage(
                    "http://localhost:8089/images/${_currentUser!.image!}")
                    : const AssetImage(
                    'assets/default_avatar.png')
                as ImageProvider,
                onBackgroundImageError: (error, stackTrace) {
                  debugPrint("Failed to load image: $error");
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                _currentUser?.name ?? "N/A",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  _buildProfileCard('Email', _currentUser?.email,
                      Icons.email),
                  _buildProfileCard(
                      'Phone', _currentUser?.cell, Icons.phone),
                  _buildProfileCard(
                      'Address', _currentUser?.address, Icons.location_on),
                  _buildProfileCard(
                      'Date of Birth', _currentUser?.dob, Icons.cake),
                  _buildProfileCard(
                      'Gender', _currentUser?.gender, Icons.person),
                  _buildProfileCard(
                      'Role', _currentUser?.role, Icons.work),
                  _buildProfileCard('Username',
                      _currentUser?.username, Icons.account_circle),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 20),
              child: ElevatedButton(
                onPressed: () async {
                  AuthService authService = AuthService();
                  await authService.logout();
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Logout',
                  style:
                  TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(String label, String? value, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value ?? 'N/A',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
