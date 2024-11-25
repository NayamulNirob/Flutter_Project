import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:merchandise_management_system/pages/AddProduct.dart';
import 'package:merchandise_management_system/pages/CustomerMgmtPage.dart';
import 'package:merchandise_management_system/pages/LogInPage.dart';
import 'package:merchandise_management_system/pages/StockManagementPage.dart';
import 'package:merchandise_management_system/pages/SupplierManagementPage.dart';
import 'package:merchandise_management_system/pages/TransactionPage.dart';
import 'package:merchandise_management_system/pages/UserProfilePage.dart';
import 'package:merchandise_management_system/pages/User_page.dart';
import 'package:merchandise_management_system/pages/WarehouseMgmtPage.dart';
import 'package:merchandise_management_system/pages/all_productCategory_view.dart';
import 'package:merchandise_management_system/pages/all_product_view_page.dart';
import 'package:merchandise_management_system/services/AuthService.dart';
import 'countries_view_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0; // Tracks the selected bottom nav item
  String userName = 'Admin'; // Fallback value until the user name is fetched
  final AuthService authService = AuthService();

  // Create the screens only when the widget is built
  late final List<Widget> _screens;

  // Fetch the current user's name from AuthService
  Future<void> _fetchUserName() async {
    final user = await authService.getCurrentUser();
    print('User fetched successfully: ${user!.name}');
    setState(() {
      userName = user.name ?? 'Admin'; // Use 'Admin' as fallback
    });
  }

  @override
  void initState() {
    super.initState();
    // Fetch the user name when the widget is initialized
    _fetchUserName();
    // Initialize the screens list
    _screens = [
      // Admin Dashboard screen
      Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Admin Dashboard',
              style: TextStyle(color: Colors.white)),
          automaticallyImplyLeading: false, // Hides the back button
          backgroundColor: Colors.deepPurple,
        ),
        body: FutureBuilder<void>(
          // Fetching user name asynchronously
          future: _fetchUserName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading spinner while waiting for the user name
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Display error message if something went wrong
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              // Show the dashboard when the data is loaded
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
                            icon: Icons.production_quantity_limits_rounded,
                            label: 'Manage Products',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AllProductViewPage()),
                              );
                            },
                          ),
                          _buildCard(
                            context,
                            color: Colors.greenAccent,
                            icon: Icons.category,
                            label: 'Category',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AllProductcategoryView()),
                              );
                            },
                          ),
                          _buildCard(
                            context,
                            color: Colors.greenAccent,
                            icon: Icons.add,
                            label: 'Add Products',
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AddProductPage()),
                              );
                            },
                          ),
                          _buildCard(
                            context,
                            color: Colors.greenAccent,
                            icon: Icons.shopping_cart,
                            label: 'Buyers',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CustomerManagementPage()),
                              );
                            },
                          ),
                          _buildCard(
                            context,
                            color: Colors.greenAccent,
                            icon: Icons.credit_card,
                            label: 'Transaction',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TransactionPage()),
                              );
                            },
                          ),
                          _buildCard(
                            context,
                            color: Colors.greenAccent,
                            icon: Icons.map_outlined,
                            label: 'Country View Page',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CountriesViewPage()),
                              );
                            },
                          ),
                          _buildCard(
                            context,
                            color: Colors.greenAccent,
                            icon: Icons.location_city,
                            label: 'Warehouse Managemennt',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WarehouseMgmtPage()),
                              );
                            },
                          ),
                          _buildCard(
                            context,
                            color: Colors.cyanAccent,
                            icon: Icons.people,
                            label: 'Suppliers',
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SupplierManagementPage()),
                              );
                            },
                          ),
                          _buildCard(
                            context,
                            color: Colors.cyanAccent,
                            icon: Icons.storage,
                            label: 'Stock Management',
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const StockManagementPage()),
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
      // Example screen for Phone button (you can replace it with any other page)
      Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:
          const Text('Phone Screen', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.deepPurple,
        ),
        body: const Center(
          child: Text(
            'Phone Screen Placeholder',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ];
  }

  // Method to handle bottom navigation item selection
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
        currentIndex: _selectedIndex, // Set the current selected index
        onTap: _onItemTapped, // Handle item taps
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
            icon: Icon(Icons.qr_code),
            label: 'Scan',
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
