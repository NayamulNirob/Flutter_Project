import 'package:flutter/material.dart';
import 'package:merchandise_management_system/pages/AllProductcategoryUserView.dart';
import 'package:merchandise_management_system/pages/LogInPage.dart';
import 'package:merchandise_management_system/pages/OrderItemPage.dart';
import 'package:merchandise_management_system/pages/UserProfilePage.dart';
import 'package:merchandise_management_system/pages/all_productCategory_view.dart';
import 'package:merchandise_management_system/services/AuthService.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  int _selectedIndex = 0; // Tracks the selected bottom nav item
  String userName = 'User'; // Fallback value until the user name is fetched
  final AuthService authService = AuthService();

  // Create the screens only when the widget is built
  late final List<Widget> _screens;

  // Fetch the current user's name from AuthService
  Future<void> _fetchUserName() async {
    final user = await authService.getCurrentUser();
    print('User fetched successfully: ${user!.name}');
    setState(() {
      userName = user.name ?? 'User'; // Use 'Admin' as fallback
    });
  }

  @override
  void initState() {
    super.initState();
    // Fetch the user name when the widget is initialized
    _fetchUserName();
    // Initialize the screens list
    _screens = [
      // Dashboard screen
      Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('User Dashboard', style: TextStyle(color: Colors.white)),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepPurple,
        ),
        body: FutureBuilder<void>(
          future: _fetchUserName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Welcome, $userName!',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: [
                          _buildCard(
                            context,
                            color: Colors.cyanAccent,
                            icon: Icons.shopping_cart,
                            label: 'Order Products',
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => OrderItemPage()),
                              );
                            },
                          ),
                          _buildCard(
                            context,
                            color: Colors.cyanAccent,
                            icon: Icons.category,
                            label: 'Categories',
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => AllProductcategoryUserView()),
                              );
                            },
                          ),
                          _buildCard(
                            context,
                            color: Colors.greenAccent,
                            icon: Icons.person_pin_rounded,
                            label: 'Profile',
                            onTap: () async {
                              await AuthService().logout();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => UserProfileView()),
                              );
                            },
                          ),
                          _buildCard(
                            context,
                            color: Colors.red,
                            icon: Icons.logout,
                            label: 'Logout',
                            onTap: () async {
                              await AuthService().logout();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
      // Phone screen (second tab)
      Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Phone Screen', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.deepPurple,
        ),
        body: const Center(
          child: Text(
            'Phone Screen Placeholder',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      // UserProfileView (for Settings tab)
      UserProfileView(), // This is your third screen for the "Settings" tab
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display the corresponding screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: 'Phone',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
      BuildContext context, {
        required Color color,
        required IconData icon,
        required String label,
        required VoidCallback onTap,
      }) {
    return Card(
      color: color.withOpacity(0.2),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

