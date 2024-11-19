import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import '../models/Product.dart';
import '../models/Supplier.dart';
import '../models/SubCategories.dart';
import '../services/ProductService.dart';

class EditProductPage extends StatefulWidget {
  final Product product;

  const EditProductPage({required this.product, super.key});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  final ProductService _productService = ProductService();
  final ImagePicker _picker = ImagePicker();
  XFile? selectedImage;
  Uint8List? webImage;

  // Form Controllers
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;
  late TextEditingController _taxController;
  late TextEditingController _paidController;
  late TextEditingController _dueController;
  late TextEditingController _totalPriceController;
  late TextEditingController _sizesController;

  Supplier? _selectedSupplier;
  SubCategories? _selectedSubCategory;
  List<Supplier> _suppliers = [];
  List<SubCategories> _subCategories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadSuppliersAndSubCategories();
  }

  void _initializeControllers() {
    _nameController = TextEditingController(text: widget.product.name);
    _descriptionController = TextEditingController(text: widget.product.description);
    _priceController = TextEditingController(text: widget.product.price.toString());
    _quantityController = TextEditingController(text: widget.product.quantity.toString());
    _taxController = TextEditingController(text: widget.product.tax.toString());
    _paidController = TextEditingController(text: widget.product.paid.toString());
    _dueController = TextEditingController(text: widget.product.due.toString());
    _totalPriceController = TextEditingController(text: widget.product.totalPrice.toString());
    _sizesController = TextEditingController(text: widget.product.sizes);
    _selectedSupplier = widget.product.supplier;
    _selectedSubCategory = widget.product.subCategories;
  }

  Future<void> _loadSuppliersAndSubCategories() async {
    try {
      final suppliers = await _productService.fetchSuppliers();
      final subCategories = await _productService.fetchSubCategories();

      setState(() {
        _suppliers = suppliers;
        _subCategories = subCategories;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  Future<void> _updateProduct() async {
    if (_formKey.currentState!.validate()) {
      final updatedProduct = Product(
        id: widget.product.id,
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        quantity: int.parse(_quantityController.text),
        tax: double.parse(_taxController.text),
        paid: double.parse(_paidController.text),
        due: double.parse(_dueController.text),
        totalPrice: double.parse(_totalPriceController.text),
        sizes: _sizesController.text,
        supplier: _selectedSupplier!,
        subCategories: _selectedSubCategory!,
        productCode: widget.product.productCode,
        purchaseDate: widget.product.purchaseDate,
        image: selectedImage?.path ?? widget.product.image, // Use existing image if no new image is selected
      );

      try {
        await _productService.updateProduct(updatedProduct, widget.product.id);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product updated successfully!')),
        );
        Navigator.pop(context);
      } catch (e) {
        print('Error updating product: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating product: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  prefixIcon: Icon(Icons.label, color: Colors.deepOrange),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter product name' : null,
              ),
              const SizedBox(height: 16),
              // Description Field
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.description, color: Colors.deepOrange),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter description' : null,
              ),
              const SizedBox(height: 16),
              // Other Fields (Price, Quantity, Tax, Paid, Due, etc.)
              // Example: Price Field
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  prefixIcon: Icon(Icons.attach_money, color: Colors.deepOrange),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter product price' : null,
              ),
              const SizedBox(height: 16),
              // Quantity
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  prefixIcon: Icon(Icons.production_quantity_limits,
                      color: Colors.deepOrange),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Enter product quantity' : null,
              ),
              const SizedBox(height: 16),

              // Image Picker
              ElevatedButton.icon(
                onPressed: pickImage,
                icon: const Icon(Icons.image, color: Colors.white),
                label: const Text('Pick Image'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,
                ),
              ),
              const SizedBox(height: 16),

              // // Supplier
              // DropdownButtonFormField<Supplier>(
              //   value: _selectedSupplier,
              //   items: _suppliers
              //       .map((supplier) => DropdownMenuItem(
              //     value: supplier,
              //     child: Text(supplier.name),
              //   ))
              //       .toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedSupplier = value;
              //     });
              //   },
              //   decoration: const InputDecoration(
              //     labelText: 'Supplier',
              //     prefixIcon: Icon(Icons.store, color: Colors.deepOrange),
              //   ),
              // ),
              // const SizedBox(height: 16),
              //
              //
              // // Subcategory
              // DropdownButtonFormField<SubCategories>(
              //   value: _selectedSubCategory,
              //   items: _subCategories
              //       .map((category) => DropdownMenuItem(
              //     value: category,
              //     child: Text(category.name),
              //   ))
              //       .toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedSubCategory = value;
              //     });
              //   },
              //   decoration: const InputDecoration(
              //     labelText: 'Subcategory',
              //     prefixIcon: Icon(Icons.category, color: Colors.deepOrange),
              //   ),
              // ),
              // const SizedBox(height: 16),



              // Save Button
              ElevatedButton(
                onPressed: _updateProduct,
                child: const Text('Update Product'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
