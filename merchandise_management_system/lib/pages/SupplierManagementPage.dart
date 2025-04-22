import 'package:flutter/material.dart';
import 'package:merchandise_management_system/models/Country.dart';
import 'package:merchandise_management_system/models/Supplier.dart';
import 'package:merchandise_management_system/pages/admin_page.dart';
import 'package:merchandise_management_system/services/CountryService.dart';
import 'package:merchandise_management_system/services/SupplierService.dart';

class SupplierManagementPage extends StatefulWidget {
  const SupplierManagementPage({super.key});

  @override
  State<SupplierManagementPage> createState() => _SupplierManagementPageState();
}

class _SupplierManagementPageState extends State<SupplierManagementPage> {
  late Future<List<Supplier>> futureSuppliers;
  late Future<List<Country>> futureCountries;
  final SupplierService _service = SupplierService();
  final CountryService _countryService = CountryService();
  List<Country> countries = [];

  @override
  void initState() {
    super.initState();
    futureSuppliers = _service.fetchSuppliers();
    futureCountries = _loadCountries();
  }

  Future<List<Country>> _loadCountries() async {
    final loadedCountries = await _countryService.fetchCountries();
    setState(() {
      countries = loadedCountries;
    });
    return loadedCountries;
  }

  void _refreshSuppliers() {
    setState(() {
      futureSuppliers = _service.fetchSuppliers();
    });
  }

  Future<void> _showSupplierForm({Supplier? supplier}) async {
    if (countries.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Countries are still loading, please wait.')),
      );
      return;
    }

    final isEdit = supplier != null;
    final formKey = GlobalKey<FormState>();

    // Controllers for text fields
    final nameController = TextEditingController(text: supplier?.name ?? '');
    final contactPersonController =
        TextEditingController(text: supplier?.contactPerson ?? '');
    final emailController = TextEditingController(text: supplier?.email ?? '');
    final phoneController = TextEditingController(text: supplier?.phone ?? '');
    final addressController =
        TextEditingController(text: supplier?.address ?? '');
    final organizationController =
        TextEditingController(text: supplier?.organization ?? '');
    final statusController =
        TextEditingController(text: supplier?.status ?? 'Active');

    Country? selectedCountry = supplier?.country != null
        ? countries.firstWhere(
            (country) => country.id == supplier?.country.id,
            orElse: () => countries.first, // Fallback to the first country
          )
        : (countries.isNotEmpty ? countries.first : null);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEdit ? 'Edit Supplier' : 'Add Supplier'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: contactPersonController,
                    decoration:
                        const InputDecoration(labelText: 'Contact Person'),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(labelText: 'Phone'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: 'Address'),
                  ),
                  TextFormField(
                    controller: organizationController,
                    decoration:
                        const InputDecoration(labelText: 'Organization'),
                  ),
                  DropdownButtonFormField<Country>(
                    value: selectedCountry,
                    decoration: const InputDecoration(labelText: 'Country'),
                    items: countries.map((Country country) {
                      return DropdownMenuItem<Country>(
                        value: country,
                        child: Text(country.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCountry = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a country';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: statusController,
                    decoration: const InputDecoration(labelText: 'Status'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final newSupplier = Supplier(
                    id: supplier?.id ?? 0,
                    name: nameController.text,
                    contactPerson: contactPersonController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    address: addressController.text,
                    organization: organizationController.text,
                    status: statusController.text,
                    createdAt: supplier?.createdAt ?? DateTime.now(),
                    updatedAt: DateTime.now(),
                    country: selectedCountry!,
                  );

                  if (isEdit) {
                    await _service.updateSupplier(newSupplier);
                  } else {
                    await _service.addSupplier(newSupplier);
                  }

                  _refreshSuppliers();
                  Navigator.pop(context);
                }
              },
              child: Text(isEdit ? 'Update' : 'Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteSupplier(int id) async {
    await _service.deleteSupplier(id);
    _refreshSuppliers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supplier Management'),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AdminPage()),
            );// Ensure this matches the navigation stack
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),

      body: FutureBuilder<List<Supplier>>(
        future: futureSuppliers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No suppliers available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final supplier = snapshot.data![index];
                return ListTile(
                  title: Text(supplier.name),
                  subtitle: Text(
                      '${supplier.email ?? 'No email'} | ${supplier.country.name}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.green),
                        onPressed: () => _showSupplierForm(supplier: supplier),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteSupplier(supplier.id),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showSupplierForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
