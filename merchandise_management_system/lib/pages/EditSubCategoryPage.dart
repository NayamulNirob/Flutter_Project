import 'package:flutter/material.dart';
import 'package:merchandise_management_system/models/SubCategories.dart';
import 'package:merchandise_management_system/services/SubCategoriesService.dart';

class EditSubCategoryPage extends StatefulWidget {
  final SubCategories subCategory;

  const EditSubCategoryPage({super.key, required this.subCategory});

  @override
  _EditSubCategoryPageState createState() => _EditSubCategoryPageState();
}

class _EditSubCategoryPageState extends State<EditSubCategoryPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final SubCategoriesService _service = SubCategoriesService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.subCategory.name;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        final updatedSubCategory = SubCategories(
          id: widget.subCategory.id, // Use the existing `id`
          name: _nameController.text,
          productCategory: widget.subCategory.productCategory,
        );

        // Pass the `id` and the updated subcategory object
        await _service.updateSubCategory(widget.subCategory.id, updatedSubCategory);

        Navigator.pop(context, updatedSubCategory);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Subcategory updated successfully')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update subcategory')));
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
        title: Text('Edit Subcategory'),
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
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
