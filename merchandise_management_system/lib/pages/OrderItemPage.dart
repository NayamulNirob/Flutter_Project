import 'package:flutter/material.dart';
import 'package:merchandise_management_system/models/OrderItem.dart';
import 'package:merchandise_management_system/models/Product.dart';
import 'package:merchandise_management_system/services/OrderItemService.dart';
import 'package:merchandise_management_system/services/ProductService.dart';

class OrderItemPage extends StatefulWidget {
  @override
  _OrderItemPageState createState() => _OrderItemPageState();
}

class _OrderItemPageState extends State<OrderItemPage> {
  final OrderItemService _orderItemService = OrderItemService();
  final ProductService _productService = ProductService();
  List<Product> _products = [];
  bool _isLoading = true;
  Product? _selectedProduct;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      List<Product> products = await _productService.fetchProducts();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load products: $e')),
      );
    }
  }

  void _placeOrder() async {
    if (_selectedProduct == null || _quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a product and enter a valid quantity')),
      );
      return;
    }

    OrderItem orderItem = OrderItem(
      customer: null, // Set customer details accordingly
      product: _selectedProduct,
      quantity: _quantity,
      status: 'Pending',
      orderDate: DateTime.now(),
      deliveryDate: DateTime.now().add(Duration(days: 7)),
      totalPrice: _selectedProduct!.price! * _quantity,
    );

    try {
      await _orderItemService.createOrderItem(orderItem);
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
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<Product>(
              isExpanded: true,
              hint: Text('Select a Product'),
              value: _selectedProduct,
              onChanged: (Product? newValue) {
                setState(() {
                  _selectedProduct = newValue;
                });
              },
              items: _products.map<DropdownMenuItem<Product>>((Product product) {
                return DropdownMenuItem<Product>(
                  value: product,
                  child: Text(product.name ?? 'Unknown Product'),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantity',
              ),
              onChanged: (value) {
                setState(() {
                  _quantity = int.tryParse(value) ?? 1;
                });
              },
            ),
            SizedBox(height: 16),
            Text('Total Price: \$${_selectedProduct != null ? _selectedProduct!.price! * _quantity : 0}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _placeOrder,
              child: Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
