import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchandise_management_system/models/ProductCategory.dart';
import 'package:merchandise_management_system/services/ProductCategoryService.dart';
import 'SubCategoriesPage.dart';

class AllProductcategoryView extends StatefulWidget {
  const AllProductcategoryView({super.key});

  @override
  State<AllProductcategoryView> createState() => _AllProductcategoryViewState();
}

class _AllProductcategoryViewState extends State<AllProductcategoryView> {
  late Future<List<ProductCategory>> futureProductsCategories;

  @override
  void initState() {
    super.initState();
    futureProductsCategories =
        ProductCategoryService().fetchProductCategories();
  }

  Widget buildImage(String imageUrl) {
    if (imageUrl.endsWith('.svg')) {
      return SvgPicture.network(
        imageUrl,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
        placeholderBuilder: (BuildContext context) => const Center(
          child: CircularProgressIndicator(),
        ),
        
      );
    } else {
      return Image.network(
        imageUrl,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image, size: 80, color: Colors.grey),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Available Categories',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 6,
      ),
      backgroundColor: Colors.blueGrey[50],
      body: FutureBuilder<List<ProductCategory>>(
        future: futureProductsCategories,
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductCategory>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Categories available'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final category = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SubCategoriesPage(category: category),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 8,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadowColor: Colors.black.withOpacity(0.2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          child: buildImage(
                              "http://localhost:8089/api/image/${category.image}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category.name,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                category.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(Icons.code, color: Colors.teal),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Code: ${category.categoryCode}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.teal,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
