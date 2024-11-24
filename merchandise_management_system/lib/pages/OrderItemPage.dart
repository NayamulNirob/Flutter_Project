import 'package:flutter/material.dart';
import 'package:merchandise_management_system/models/Customer.dart';
import 'package:merchandise_management_system/models/OrderItem.dart';
import 'package:merchandise_management_system/models/Product.dart';
import 'package:merchandise_management_system/pages/User_page.dart';
import 'package:merchandise_management_system/services/CustomerService.dart';
import 'package:merchandise_management_system/services/ProductService.dart';

class OrderItemPage extends StatefulWidget {
  @override
  _OrderItemPageState createState() => _OrderItemPageState();
}

class _OrderItemPageState extends State<OrderItemPage> {
  final CustomerService _customerService = CustomerService();
  final ProductService _productService = ProductService();
  List<Product> _products = [];
  List<Customer> _customers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      List<Product> products = await _productService.fetchProducts();
      List<Customer> customers = await _customerService.fetchCustomers();
      setState(() {
        _products = products;
        _customers = customers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data: $e')),
      );
    }
  }

  void _showOrderPopup(Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
              16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
          child: OrderForm(
            product: product,
            customers: _customers,
            onOrderPlaced: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Order placed successfully!')),
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
        title: Text('Products'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserPage()),
          ), // GoRouter's way to navigate back
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                Product product = _products[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.network(
                          "http://localhost:8089/images/${product.image}",
                          height: 200,
                          // Adjust height for a larger image
                          width: double.infinity,
                          fit: BoxFit.cover,
                          // Ensures the image fits well inside the card
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            height:
                                200, // Ensure placeholder has the same height
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: Icon(Icons.image_not_supported, size: 50),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Name
                            Text(
                              product.name ?? 'Unknown Product',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    18, // Slightly larger font for emphasis
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Product Price and Description
                            Text(
                              '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              product.description ?? 'No description available',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      // Order Now Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _showOrderPopup(product),
                          child: Text(
                            'Order Now',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                          ),
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

  OrderForm({
    required this.product,
    required this.customers,
    required this.onOrderPlaced,
  });

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  Customer? _selectedCustomer;
  int _quantity = 1;
  String _selectedSize = "M";

  @override
  Widget build(BuildContext context) {
    double totalPrice = (widget.product.price ?? 0) * _quantity;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Place Order for ${widget.product.name}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<Customer>(
            decoration: InputDecoration(
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
                .map<DropdownMenuItem<Customer>>((Customer customer) {
              return DropdownMenuItem<Customer>(
                value: customer,
                child: Text(customer.name ?? 'Unknown'),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
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
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Select Size',
              border: OutlineInputBorder(),
            ),
            value: _selectedSize,
            onChanged: (String? newValue) {
              setState(() {
                _selectedSize = newValue ?? _selectedSize;
              });
            },
            items: ['S', 'M', 'L', 'XL', 'XXL', 'KG', 'GM']
                .map<DropdownMenuItem<String>>((String size) {
              return DropdownMenuItem<String>(
                value: size,
                child: Text(size),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Text(
            'Total Price: \$${totalPrice.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    SnackBar(content: Text('Please select a customer')),
                  );
                }
              },
              child: Text('Confirm Order'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
