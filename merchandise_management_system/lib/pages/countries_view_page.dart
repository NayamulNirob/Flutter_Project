import 'package:flutter/material.dart';
import 'package:merchandise_management_system/models/Country.dart';
import 'package:merchandise_management_system/pages/CountryEditPage.dart';
import 'package:merchandise_management_system/services/CountryService.dart';

class CountriesViewPage extends StatefulWidget {
  const CountriesViewPage({super.key});

  @override
  State<CountriesViewPage> createState() => _AllCountryViewPageState();
}

class _AllCountryViewPageState extends State<CountriesViewPage> {
  late Future<List<Country>> futureCountries;

  @override
  void initState() {
    super.initState();
    futureCountries = CountryService().fetchCountries();
  }

  Future<void> _refreshCountries() async {
    setState(() {
      futureCountries = CountryService().fetchCountries();
    });
  }

  void _editCountry(Country country) {
    // Navigate to the edit page and pass the country data
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CountryEditPage(country: country)),
    ).then((_) => _refreshCountries());
  }

  Future<void> _deleteCountry(int id) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this country?"),
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
        await CountryService().deleteCountry(id);
        _refreshCountries();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Country deleted successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete country: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Business Countries',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      backgroundColor: Colors.grey[200],
      body: FutureBuilder<List<Country>>(
        future: futureCountries,
        builder: (BuildContext context, AsyncSnapshot<List<Country>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No business available'));
          } else {
            return RefreshIndicator(
              onRefresh: _refreshCountries,
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final country = snapshot.data![index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  country.name ?? 'Unnamed Country',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, color: Colors.blueAccent),
                                    onPressed: () async {
                                      final updatedCountry = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CountryEditPage(country: country),
                                        ),
                                      );
                                      if (updatedCountry != null) {
                                        setState(() {
                                          // Update the country list with the new details if returned
                                          futureCountries = CountryService().fetchCountries();
                                        });
                                      }
                                    },
                                  ),
                                  // IconButton(
                                  //   icon: const Icon(Icons.edit, color: Colors.blue),
                                  //   onPressed: () => _editCountry(country),
                                  // ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _deleteCountry(country.id!),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Country Business: ${country.bussiness ?? 'Not Available'}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Country Sale: ${country.sale ?? 'Unknown'}',
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
                                'Progress: \$${country.progress}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.indigo,
                                ),
                              ),
                              Text(
                                'Status: \$${country.status}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.indigo,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}



