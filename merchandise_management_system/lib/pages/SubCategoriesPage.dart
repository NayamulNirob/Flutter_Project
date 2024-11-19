import 'package:flutter/material.dart';
import 'package:merchandise_management_system/models/SubCategories.dart';
import '../services/SubCategoriesService.dart';


class SubCategoriesPage extends StatefulWidget {
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
        _subCategories = subCategories;
        _isLoading = false;
      });
    } catch (e) {
      print("Error loading subcategories: $e");
    }
  }

  Future<void> _addSubCategory() async {
    // Navigate to a form page to add a new subcategory
    // After successful addition, reload the data
    await _loadSubCategories();
  }

  Future<void> _editSubCategory(SubCategories subCategory) async {
    // Navigate to a form page to edit the subcategory
    // After successful update, reload the data
    await _loadSubCategories();
  }

  Future<void> _deleteSubCategory(int id) async {
    try {
      await _service.deleteSubCategory(id);
      setState(() {
        _subCategories.removeWhere((element) => element.id == id);
      });
    } catch (e) {
      print("Error deleting subcategory: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SubCategories"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addSubCategory,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _subCategories.length,
        itemBuilder: (context, index) {
          final subCategory = _subCategories[index];
          return ListTile(
            title: Text(subCategory.name),
            subtitle: Text("Category: ${subCategory.productCategory.name}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _editSubCategory(subCategory),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteSubCategory(subCategory.id),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
