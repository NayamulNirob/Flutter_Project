import 'package:flutter/material.dart';
import 'package:merchandise_management_system/models/SubCategories.dart';
import 'package:merchandise_management_system/services/SubCategoriesService.dart';
import 'package:merchandise_management_system/models/ProductCategory.dart';

class AddSubCategoryPage extends StatefulWidget {
  final ProductCategory category;

  const AddSubCategoryPage({Key? key, required this.category}) : super(key: key);

  @override
  _AddSubCategoryPageState createState() => _AddSubCategoryPageState();
}

class _AddSubCategoryPageState extends State<AddSubCategoryPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final SubCategoriesService _service = SubCategoriesService();
  bool _isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Pass a default `id` placeholder (e.g., 0)
        final newSubCategory = SubCategories(
          id: 0, // Placeholder `id` for new subcategories
          name: _nameController.text,
          productCategory: widget.category,
        );

        final createdSubCategory = await _service.createSubCategory(newSubCategory);
        Navigator.pop(context, createdSubCategory);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Subcategory added successfully')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add subcategory')));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Subcategory to ${widget.category.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Subcategory Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name for the subcategory';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Subcategory'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
