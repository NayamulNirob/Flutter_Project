import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:merchandise_management_system/models/Product.dart';
import 'package:merchandise_management_system/models/SubCategories.dart';
import 'package:merchandise_management_system/models/Customer.dart';
import 'package:merchandise_management_system/services/ProductService.dart';
import 'package:merchandise_management_system/services/CustomerService.dart';

class AllProductViewUserPage extends StatefulWidget {
  final SubCategories? subCategory;

  const AllProductViewUserPage({Key? key, this.subCategory}) : super(key: key);

  @override
  State<AllProductViewUserPage> createState() => _AllProductViewUserPageState();
}

class _AllProductViewUserPageState extends State<AllProductViewUserPage> {
  final ProductService _productService = ProductService();
  final CustomerService _customerService = CustomerService();
  bool _isLoading = true;
  List<Product> _filteredProducts = [];
  List<Customer> _customers = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final products = await _productService.fetchProducts();
      final customers = await _customerService.fetchCustomers();
      setState(() {
        _filteredProducts = widget.subCategory != null
            ? products.where((product) => product.subCategories.id == widget.subCategory!.id).toList()
            : products;
        _customers = customers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading data: $e')),
      );
    }
  }

  void _showOrderPopup(Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: OrderForm(
            product: product,
            customers: _customers,
            onOrderPlaced: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Order placed successfully!')),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.subCategory != null
              ? 'Products in ${widget.subCategory!.name}'
              : 'All Products',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      backgroundColor: Colors.grey[100],
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _filteredProducts.isEmpty
          ? const Center(child: Text('No products available'))
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _filteredProducts.length,
        itemBuilder: (context, index) {
          final product = _filteredProducts[index];
          return Card(
            elevation: 8,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: product.image.isNotEmpty
                      ? Image.network(
                    "http://localhost:8089/images/${product.image}",
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        height: 250,
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            size: 80,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  )
                      : Container(
                    color: Colors.grey[300],
                    height: 250,
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                // Product Details
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Price: \$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => _showOrderPopup(product),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrangeAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Order Now'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OrderForm extends StatefulWidget {
  final Product product;
  final List<Customer> customers;
  final VoidCallback onOrderPlaced;

  const OrderForm({
    required this.product,
    required this.customers,
    required this.onOrderPlaced,
  });

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  Customer? _selectedCustomer;
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    double totalPrice = (widget.product.price ?? 0) * _quantity;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order ${widget.product.name}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<Customer>(
            decoration: const InputDecoration(
              labelText: 'Select Customer',
              border: OutlineInputBorder(),
            ),
            value: _selectedCustomer,
            onChanged: (Customer? newValue) {
              setState(() {
                _selectedCustomer = newValue;
              });
            },
            items: widget.customers
                .map<DropdownMenuItem<Customer>>((customer) => DropdownMenuItem(
              value: customer,
              child: Text(customer.name ?? 'Unknown'),
            ))
                .toList(),
          ),
          const SizedBox(height: 16),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Quantity',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _quantity = int.tryParse(value) ?? 1;
              });
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Total: \$${totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_selectedCustomer != null) {
                  widget.onOrderPlaced();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a customer')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Place Order'),
            ),
          ),
        ],
      ),
    );
  }
}
