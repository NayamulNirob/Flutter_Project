import 'package:flutter/material.dart';
import 'package:merchandise_management_system/pages/AddProduct.dart';
import 'package:merchandise_management_system/pages/LogInPage.dart';
import 'package:merchandise_management_system/pages/ProfileViewPage.dart';
import 'package:merchandise_management_system/pages/SubCategoriesPage.dart';
import 'package:merchandise_management_system/pages/all_productCategory_view.dart';
import 'package:merchandise_management_system/pages/all_product_view_page.dart';


import 'countries_view_page.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: const Text('Admin Dashboard', style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false, // Hides the back button
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome, Admin!',
              style: TextStyle(
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
                    icon: Icons.people,
                    label: 'View Users',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileViewPage()),
                      );
                      print("View Users clicked");
                    },
                  ),
                  _buildCard(
                    context,
                    color: Colors.cyanAccent,
                    icon: Icons.production_quantity_limits_rounded,
                    label: 'Manage Products',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AllProductViewPage()),
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
                        MaterialPageRoute(builder: (context) => const AddProductPage()),
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
                        MaterialPageRoute(builder: (context) => const AllProductcategoryView()),
                      );
                      print("Category clicked");
                    },
                  ),
                  _buildCard(
                    context,
                    color: Colors.greenAccent,
                    icon: Icons.category,
                    label: 'Sub Category',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  SubCategoriesPage()),
                      );
                      print("Category clicked");
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
                        MaterialPageRoute(builder: (context) => const CountriesViewPage()),
                      );
                    },
                  ),
                  _buildCard(
                    context,
                    color: Colors.red,
                    icon: Icons.logout,
                    label: 'Logout',
                    onTap: () {
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
                style: TextStyle(
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
