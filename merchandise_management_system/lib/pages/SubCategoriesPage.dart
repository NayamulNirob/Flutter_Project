import 'package:flutter/material.dart';
import 'package:merchandise_management_system/models/ProductCategory.dart';
import 'package:merchandise_management_system/models/SubCategories.dart';
import 'package:merchandise_management_system/pages/AddSubCategoryPage.dart';
import 'package:merchandise_management_system/pages/EditSubCategoryPage.dart';
import 'package:merchandise_management_system/pages/all_product_view_page.dart';
import '../services/SubCategoriesService.dart';

class SubCategoriesPage extends StatefulWidget {
  final ProductCategory category;

  const SubCategoriesPage({Key? key, required this.category}) : super(key: key);

  @override
  _SubCategoriesPageState createState() => _SubCategoriesPageState();

}

class _SubCategoriesPageState extends State<SubCategoriesPage> {
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

  Future<void> _addSubCategory() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddSubCategoryPage(category: widget.category),
      ),
    );
    if (result != null) {
      _loadSubCategories();
    }
  }

  Future<void> _editSubCategory(SubCategories subCategory) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditSubCategoryPage(subCategory: subCategory),
      ),
    );
    if (result != null) {
      _loadSubCategories();
    }
  }


  // Future<void> _deleteSubCategory(int id) async {
  //   bool confirm = await showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text('Confirm Delete'),
  //       content: Text('Are you sure you want to delete this subcategory?'),
  //       actions: [
  //         TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancel')),
  //         TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Delete')),
  //       ],
  //     ),
  //   );
  //
  //   if (confirm) {
  //     try {
  //       await _service.deleteSubCategory(id);
  //       setState(() {
  //         _subCategories.removeWhere((element) => element.id == id);
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Subcategory deleted successfully.')));
  //     } catch (e) {
  //       print("Error deleting subcategory: $e");
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete subcategory.')));
  //     }
  //   }
  // }

  Future<void> _deleteSubCategory(int id) async {
    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this subcategory?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Delete')),
        ],
      ),
    );

    if (confirm) {
      try {
        bool success = await _service.deleteSubCategory(id);
        if (success) {
          setState(() {
            _subCategories.removeWhere((element) => element.id == id);
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Subcategory deleted successfully.')));
        }
      } catch (e) {
        print("Error deleting subcategory: $e");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete subcategory. Please try again.')));
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subcategories for ${widget.category.name}"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Add Subcategory',
            onPressed: _addSubCategory,
          ),
        ],
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
                      builder: (context) => AllProductViewPage(subCategory: subCategory),
                    ),
                  );
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      tooltip: 'Edit Subcategory',
                      onPressed: () => _editSubCategory(subCategory),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      tooltip: 'Delete Subcategory',
                      onPressed: () => _deleteSubCategory(subCategory.id),
                    ),
                  ],
                ),
              )
          );
        },
      ),
    );
  }
}
