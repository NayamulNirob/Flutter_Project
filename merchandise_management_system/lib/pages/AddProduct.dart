import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'dart:typed_data';
import 'package:merchandise_management_system/models/Product.dart';
import 'package:merchandise_management_system/models/SubCategories.dart';
import 'package:merchandise_management_system/services/ProductService.dart';
import '../models/Supplier.dart';
import 'package:http/http.dart' as http;

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? selectedImage;
  Uint8List? webImage;



  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController()..text='Women Floral Print Co-ord Set';
  final TextEditingController _descriptionController = TextEditingController()..text='We introduce our self as a pioneer in the field of Womens Floral Print Co-ord Set. Elevate your look with our stunning 100% Viscose black floral print co-ord set.';
  final TextEditingController _priceController = TextEditingController()..text='250';
  final TextEditingController _quantityController = TextEditingController()..text='100';
  final TextEditingController _taxController = TextEditingController()..text='10';
  final TextEditingController _paidController = TextEditingController()..text='27500';
  final TextEditingController _dueController = TextEditingController()..text='00000';
  final TextEditingController _totalPriceController = TextEditingController()..text='27500';
  final TextEditingController _sizesController = TextEditingController()..text='free';

  final DateTime _purchaseDate = DateTime.now();
  Supplier? _selectedSupplier;
  SubCategories? _selectedSubCategory;
  List<Supplier> _suppliers = [];
  List<SubCategories> _subCategories = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final suppliers = await ProductService().fetchSuppliers();
      final subCategories = await ProductService().fetchSubCategories();
      setState(() {
        _suppliers = suppliers;
        _subCategories = subCategories;
      });
    } catch (e) {
      print("Error loading data: $e");
    }
  }

  Future<void> pickImage() async {
    if (kIsWeb) {
      // For Web: Use image_picker_web to pick image and store as bytes
      var pickedImage = await ImagePickerWeb.getImageAsBytes();
      if (pickedImage != null) {
        setState(() {
          webImage = pickedImage; // Store the picked image as Uint8List
        });
      }
    } else {
      // For Mobile: Use image_picker to pick image
      final XFile? pickedImage =
      await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          selectedImage = pickedImage;
        });
      }
    }
  }

  Future<void> _saveProduct() async {
    if (_formKey.currentState!.validate() && selectedImage != null || webImage != null) {
      final product = Product(
        id: 0,
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        purchaseDate: _purchaseDate,
        quantity: int.parse(_quantityController.text),
        tax: double.parse(_taxController.text),
        paid: double.parse(_paidController.text),
        due: double.parse(_dueController.text),
        totalPrice: double.parse(_totalPriceController.text),
        image: '',
        sizes: _sizesController.text,
        supplier: _selectedSupplier!,
        subCategories: _selectedSubCategory!,
        productCode: '',
      );

      var uri = Uri.parse('http://localhost:8089/api/product/save');
      var request = http.MultipartRequest('POST', uri);

      request.files.add(
        http.MultipartFile.fromString(
          'product',
          jsonEncode(product.toJson()), // Ensure toJson() is implemented in Product model
          contentType: MediaType('application', 'json'),
        ),
      );

      if (kIsWeb && webImage != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'image',
          webImage!,
          filename: 'upload.jpg',
          contentType: MediaType('image', 'jpeg'),
        ));
      } else if (selectedImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          selectedImage!.path,
        ));
      }

      try {
        var response = await request.send();
        if (response.statusCode == 200 || response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product added successfully!')),
          );
          _clearForm();
        } else {
          print('Failed to register. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error occurred while submitting: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding product: ${e.toString()}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete the form and upload an image.')),
      );
    }
  }


  void _clearForm() {
    _nameController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _quantityController.clear();
    _taxController.clear();
    _paidController.clear();
    _dueController.clear();
    _totalPriceController.clear();
    _sizesController.clear();
    selectedImage = null;
    webImage = null;
    setState(() {});
  }

  _calculate() {
    setState(() {
      double? price = double.tryParse(_priceController.text);
      double? quantity = double.tryParse(_quantityController.text);
      double baseTotalPrice = 0.0;

      // Calculate base total price
      if (price != null && quantity != null) {
        baseTotalPrice = price * quantity;
        _totalPriceController.text = baseTotalPrice.toStringAsFixed(2);
      }

      // Add tax to the total price
      double? tax = double.tryParse(_taxController.text);
      double finalTotalPrice = baseTotalPrice;
      if (tax != null) {
        finalTotalPrice += baseTotalPrice * (tax / 100);
        _totalPriceController.text = finalTotalPrice.toStringAsFixed(2);
      }

      // Calculate due amount by subtracting paid from the final total price
      double? paid = double.tryParse(_paidController.text);
      if (paid != null) {
        _dueController.text = (finalTotalPrice - paid).toStringAsFixed(2);
      } else {
        _dueController.text = finalTotalPrice.toStringAsFixed(2); // If no amount paid, full amount is due
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) => value == null || value.isEmpty ? 'Enter product name' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) => value == null || value.isEmpty ? 'Enter description' : null,
              ),
              TextFormField(
                controller: _priceController,
                onChanged: (value) => _calculate(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Price'),
                validator: (value) => value == null || value.isEmpty ? 'Enter price' : null,
              ),
              TextFormField(
                controller: _quantityController,
                onChanged: (value) => _calculate(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Quantity'),
                validator: (value) => value == null || value.isEmpty ? 'Enter quantity' : null,
              ),
              TextFormField(
                controller: _taxController,
                onChanged: (value) => _calculate(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Tax'),
                validator: (value) => value == null || value.isEmpty ? 'Enter tax amount' : null,
              ),
              TextFormField(
                controller: _paidController,
                onChanged: (value) => _calculate(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Paid Amount'),
                validator: (value) => value == null || value.isEmpty ? 'Enter paid amount' : null,
              ),

              TextFormField(
                controller: _dueController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Due Amount'),
                validator: (value) => value == null || value.isEmpty ? 'Enter due amount' : null,
              ),
              TextFormField(
                controller: _totalPriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Total Price'),
                validator: (value) => value == null || value.isEmpty ? 'Enter total price' : null,
              ),
              TextFormField(
                controller: _sizesController,
                decoration: const InputDecoration(labelText: 'Sizes'),
                validator: (value) => value == null || value.isEmpty ? 'Enter available sizes' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.image),
                label: const Text('Pick Image'),
                onPressed: pickImage,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<Supplier>(
                value: _selectedSupplier,
                hint: const Text('Select Supplier'),
                onChanged: (Supplier? value) {
                  setState(() {
                    _selectedSupplier = value;
                  });
                },
                items: _suppliers.map((Supplier supplier) {
                  return DropdownMenuItem<Supplier>(
                    value: supplier,
                    child: Text(supplier.name),
                  );
                }).toList(),
                validator: (value) => value == null ? 'Please select a supplier' : null,
              ),
              DropdownButtonFormField<SubCategories>(
                value: _selectedSubCategory,
                hint: const Text('Select Sub-Category'),
                onChanged: (SubCategories? value) {
                  setState(() {
                    _selectedSubCategory = value;
                  });
                },
                items: _subCategories.map((SubCategories category) {
                  return DropdownMenuItem<SubCategories>(
                    value: category,
                    child: Text(category.name),
                  );
                }).toList(),
                validator: (value) => value == null ? 'Please select a sub-category' : null,
              ),
              ElevatedButton(
                onPressed: _saveProduct,
                child: const Text('Save Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
