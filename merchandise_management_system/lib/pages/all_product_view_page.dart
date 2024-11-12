import 'package:flutter/material.dart';
import 'package:merchandise_management_system/models/Product.dart';
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
    futureProducts=ProductService().fetchProducts();


    // Print the fetched products once they are loaded
    // futureProducts.then((products) {
    //   print(products); // This will print the list of products once the future completes
    // }).catchError((error) {
    //   print('Error fetching products: $error');
    // });

  }

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text('All Available Merchant',
         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
       ),
       centerTitle: true,
       backgroundColor: Colors.deepOrangeAccent,
     ),
     backgroundColor: Colors.grey[200],
     body: FutureBuilder<List<Product>>(
       future: futureProducts,
       builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
         if (snapshot.connectionState == ConnectionState.waiting) {
           return const Center(child: CircularProgressIndicator());
         } else if (snapshot.hasError) {
           return Center(child: Text('Error: ${snapshot.error}'));
         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
           return const Center(child: Text('No Merchant available'));
         } else {
           return ListView.builder(
             padding: const EdgeInsets.all(10),
             itemCount: snapshot.data!.length,
             itemBuilder: (context, index) {
               final product = snapshot.data![index];
               return Card(
                 elevation: 5,
                 margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(15),
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     // Image with rounded corners and shadow
                     ClipRRect(
                       borderRadius: const BorderRadius.vertical(
                         top: Radius.circular(15),
                       ),
                       child: product.image != null
                           ? Image.network(
                         "http://localhost:8089/images/${product.image}",
                         width: double.infinity,
                         height: 180,
                         fit: BoxFit.cover,
                         errorBuilder: (context, error, stackTrace) {
                           return Icon(
                             Icons.fastfood,
                             size: 80,
                             color: Colors.grey[400],
                           );
                         },
                       )
                           : Image.asset(
                         'assets/placeholder.png',
                         width: double.infinity,
                         height: 180,
                         fit: BoxFit.cover,
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(12.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             product.name ?? 'Unnamed Food',
                             style: const TextStyle(
                               fontSize: 20,
                               fontWeight: FontWeight.bold,
                               color: Colors.deepOrange,
                             ),
                           ),
                           const SizedBox(height: 5),
                           Text(
                             product.description ?? 'No category available',
                             style: TextStyle(
                               fontSize: 16,
                               color: Colors.grey[600],
                             ),
                           ),
                           const SizedBox(height: 5),
                           Text(
                             'productCode: ${product.productCode  ?? 'Unknown'}', // Added "Available" text
                             style: const TextStyle(
                               fontSize: 14,
                               color: Colors.green,
                               fontWeight: FontWeight.w500,
                             ),
                           ),
                           const SizedBox(height: 10),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(
                                 '\$${product.price.toStringAsFixed(2) ?? '0.00'}',
                                 style: const TextStyle(
                                   fontSize: 18,
                                   fontWeight: FontWeight.w600,
                                   color: Colors.indigo,
                                 ),
                               ),
                               ElevatedButton(
                                 onPressed: () {
                                   print('Order this food item: ${product.name}');
                                 },
                                 style: ElevatedButton.styleFrom(
                                   backgroundColor: Colors.deepOrangeAccent,
                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(20),
                                   ),
                                 ),
                                 child: const Text('Order Now'),
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
