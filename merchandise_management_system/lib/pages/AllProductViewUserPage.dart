import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:merchandise_management_system/models/Product.dart';
import 'package:merchandise_management_system/models/SubCategories.dart';
import 'package:merchandise_management_system/services/ProductService.dart';

class AllProductViewUserPage extends StatefulWidget {
  final SubCategories? subCategory;

  const AllProductViewUserPage({Key? key, this.subCategory}) : super(key: key);

  @override
  State<AllProductViewUserPage> createState() => _AllProductViewPageState();
}

class _AllProductViewPageState extends State<AllProductViewUserPage> {
  late Future<List<Product>> futureProducts;
  bool _isLoading = true;
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final allProducts = await ProductService().fetchProducts(); // Fetch all products
      if (widget.subCategory != null) {
        // Filter products based on the subcategory if one is passed
        _filteredProducts = allProducts.where((product) =>
        product.subCategories.id == widget.subCategory!.id).toList();
      } else {
        _filteredProducts = allProducts; // If no subcategory, show all products
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print("Error loading products: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.subCategory != null
              ? 'Products in ${widget.subCategory!.name}'
              : 'All Products',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      backgroundColor: Colors.grey[100],
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _filteredProducts.isEmpty
          ? Center(child: Text('No products available'))
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
                    height: 350,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        height: 350,
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
                      // Product Name
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Product Code and Sizes as Chips
                      Wrap(
                        spacing: 8.0,
                        children: [
                          Chip(
                            label: Text(
                              'Code: ${product.productCode}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.blueGrey,
                          ),
                          Chip(
                            label: Text(
                              'Sizes: ${product.sizes}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.teal,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Description
                      Text(
                        product.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Supplier and Category
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Supplier: ${product.supplier.name}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.indigo,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Category: ${product.subCategories.name}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.deepPurple,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Financial Details
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price: \$${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Tax: ${product.tax}%',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.redAccent,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Total: \$${product.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Payment Details
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Paid: \$${product.paid.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.blueGrey,
                            ),
                          ),
                          Text(
                            'Due: \$${product.due.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Purchase Date
                      Text(
                        'Purchased on: ${DateFormat('MMM d, yyyy').format(product.purchaseDate)}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey[700],
                        ),
                      ),
                      const SizedBox(height: 15),

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
