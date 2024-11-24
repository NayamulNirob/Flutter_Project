import 'package:flutter/material.dart';
import 'package:merchandise_management_system/models/ProductCategory.dart';
import 'package:merchandise_management_system/models/SubCategories.dart';
import 'package:merchandise_management_system/pages/all_product_view_page.dart';
import 'package:merchandise_management_system/pages/AllProductViewUserPage.dart';
import '../services/SubCategoriesService.dart';

class SubCategoriesUserPage extends StatefulWidget {
  final ProductCategory category;

  const SubCategoriesUserPage({Key? key, required this.category}) : super(key: key);

  @override
  _SubCategoriesUserPageState createState() => _SubCategoriesUserPageState();

}

class _SubCategoriesUserPageState extends State<SubCategoriesUserPage> {
  final SubCategoriesService _service = SubCategoriesService();
  List<SubCategories> _subCategories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSubCategories();
  }

  Future<void> _loadSubCategories() async {
    try {
      final subCategories = await _service.fetchSubCategories();
      setState(() {
        _subCategories = subCategories.where((sc) => sc.productCategory.id == widget.category.id).toList();
        _isLoading = false;
      });
    } catch (e) {
      print("Error loading subcategories: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subcategories for ${widget.category.name}"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _subCategories.isEmpty
          ? Center(child: Text('No subcategories available for ${widget.category.name}.'))
          : ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: _subCategories.length,
        itemBuilder: (context, index) {
          final subCategory = _subCategories[index];
          return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: Icon(Icons.category, color: Colors.blueAccent, size: 40),
                title: Text(
                  subCategory.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Category: ${subCategory.productCategory.name}"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllProductViewUserPage(subCategory: subCategory),
                    ),
                  );
                },
              )
          );
        },
      ),
    );
  }
}
