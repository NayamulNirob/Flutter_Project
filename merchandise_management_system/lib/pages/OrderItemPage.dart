import 'package:flutter/material.dart';
import 'package:merchandise_management_system/models/Customer.dart';
import 'package:merchandise_management_system/models/OrderItem.dart';
import 'package:merchandise_management_system/models/Product.dart';
import 'package:merchandise_management_system/services/CustomerService.dart';
import 'package:merchandise_management_system/services/OrderItemService.dart';
import 'package:merchandise_management_system/services/ProductService.dart';

class OrderItemPage extends StatefulWidget {
  @override
  _OrderItemPageState createState() => _OrderItemPageState();
}

class _OrderItemPageState extends State<OrderItemPage> {
  final CustomerService _orderItemService = CustomerService();
  final ProductService _productService = ProductService();
  List<Product> _products = [];
  List<Customer> _customers = [];
  bool _isLoading = true;

  // Form Fields
  Product? _selectedProduct;
  Customer? _selectedCustomer;
  int _quantity = 1;
  double _totalPrice = 0;
  String _selectedSize = "M";
  DateTime _orderDate = DateTime.now();
  DateTime _deliveryDate = DateTime.now().add(Duration(days: 7));

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      List<Product> products = await _productService.fetchProducts();
      List<Customer> customers = await _orderItemService.fetchCustomers();
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

  void _updateTotalPrice() {
    if (_selectedProduct != null) {
      setState(() {
        _totalPrice = (_selectedProduct!.price ?? 0) * _quantity;
      });
    }
  }

  void _placeOrder() async {
    if (_selectedProduct == null ||
        _selectedCustomer == null ||
        _quantity <= 0 ||
        _selectedSize.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields to place an order')),
      );
      return;
    }

    OrderItem orderItem = OrderItem(
      customer: _selectedCustomer!,
      product: _selectedProduct!,
      quantity: _quantity,
      status: 'Pending',
      orderDate: _orderDate,
      deliveryDate: _deliveryDate,
      totalPrice: _totalPrice,
    );

    try {
      await _orderItemService.fetchCustomers();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order placed successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to place order: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Order'),
        backgroundColor: Colors.deepOrange,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Product Card Views
            Text(
              'Products',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ..._products.map((product) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: Image.network(
                    "http://localhost:8089/images/${product.image}",
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.image_not_supported),
                  ),
                  title: Text(product.name ?? 'Unknown Product'),
                  subtitle: Text(
                    '\$${product.price?.toStringAsFixed(2) ?? '0.00'}\n${product.description ?? 'No description'}',
                  ),
                  onTap: () {
                    setState(() {
                      _selectedProduct = product;
                      _updateTotalPrice();
                    });
                  },
                  selected: _selectedProduct == product,
                ),
              );
            }).toList(),

            const SizedBox(height: 16),

            // Customer Dropdown
            DropdownButton<Customer>(
              isExpanded: true,
              hint: Text('Select Customer'),
              value: _selectedCustomer,
              onChanged: (Customer? newValue) {
                setState(() {
                  _selectedCustomer = newValue;
                });
              },
              items: _customers
                  .map<DropdownMenuItem<Customer>>((Customer customer) {
                return DropdownMenuItem<Customer>(
                  value: customer,
                  child: Text(customer.name ?? 'Unknown'),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Quantity Input
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _quantity = int.tryParse(value) ?? 1;
                  _updateTotalPrice();
                });
              },
            ),
            const SizedBox(height: 16),

            // Size Dropdown
            DropdownButton<String>(
              isExpanded: true,
              hint: Text('Select Size'),
              value: _selectedSize,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSize = newValue ?? _selectedSize;
                });
              },
              items: ['S', 'M', 'L', 'XL', 'XXL','KG','GM']
                  .map<DropdownMenuItem<String>>((String size) {
                return DropdownMenuItem<String>(
                  value: size,
                  child: Text(size),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Total Price Display
            Text(
              'Total Price: \$${_totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Place Order Button
            ElevatedButton(
              onPressed: _placeOrder,
              child: Text('Place Order'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding:
                EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
