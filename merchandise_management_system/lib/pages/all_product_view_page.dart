import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:merchandise_management_system/models/Product.dart';
import 'package:merchandise_management_system/pages/AddProduct.dart';
import 'package:merchandise_management_system/pages/EditProductPage.dart';
import 'package:merchandise_management_system/services/ProductService.dart';

class AllProductViewPage extends StatefulWidget {
  const AllProductViewPage({super.key});

  @override
  State<AllProductViewPage> createState() => _AllProductViewPageState();
}

class _AllProductViewPageState extends State<AllProductViewPage> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ProductService().fetchProducts();
  }

  Future<void> _refreshProducts() async {
    setState(() {
      futureProducts = ProductService().fetchProducts();
    });
  }

  Future<void> _deleteProduct(int id) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this Product?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirmDelete) {
      try {
        await ProductService().deleteProduct(id);
        _refreshProducts();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product deleted successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete product: $e')),
        );
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Available Merchants',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      backgroundColor: Colors.grey[100],
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Merchants available'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Supplier: ${product.supplier.name}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.indigo,
                                  ),
                                ),
                                Text(
                                  'Category: ${product.subCategories.name}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.deepPurple,
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

                            // Action Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const AddProductPage()),
                                    );
                                  },
                                  icon: const Icon(Icons.add, color: Colors.white),
                                  label: const Text('Add New'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepOrangeAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProductPage(product: product)),
                                        );
                                      },
                                      icon: const Icon(Icons.edit, color: Colors.green),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () => _deleteProduct(product.id),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }



}
