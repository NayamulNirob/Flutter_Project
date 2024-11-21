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
      // Use SvgPicture for SVG images
      return SvgPicture.network(
        imageUrl,
        width: double.infinity,
        height: 220,
        fit: BoxFit.cover,
        placeholderBuilder: (BuildContext context) => Center(
          child: CircularProgressIndicator(),
        )
      );
    } else {
      // Use Image.network for JPG/PNG images
      return Image.network(
        imageUrl,
        width: double.infinity,
        height: 220,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Icon(
              Icons.image,
              size: 80,
              color: Colors.grey[400],
            ),
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
        backgroundColor: Colors.blueAccent,
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
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final category = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to SubCategoriesPage with selected category
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
                        vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                            child: buildImage(
                                "http://localhost:8089/api/image/${category.image}")),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                category.description,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(Icons.code, color: Colors.green),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Category Code: ${category.categoryCode}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
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
