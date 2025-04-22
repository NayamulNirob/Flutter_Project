import 'package:flutter/material.dart';
import 'package:merchandise_management_system/models/Sale.dart';
import 'package:merchandise_management_system/services/SaleService.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  _SalePageState createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  final SalesService salesService = SalesService();
  List<Sale> sales = [];
  bool isLoading = true;
  String searchQuery = '';
  double totalSales = 0.0; // Variable to store total sales value

  @override
  void initState() {
    super.initState();
    fetchSales();
  }

  Future<void> fetchSales() async {
    try {
      final fetchedSales = await salesService.fetchSales();
      setState(() {
        sales = fetchedSales;
        totalSales =
            calculateTotalSales(); // Update total sales after fetching data
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error fetching sales: $e')));
    }
  }

  double calculateTotalSales() {
    // Calculate the total sales from all fetched sales
    return sales.fold(0.0, (sum, sale) => sum + (sale.totalPrice ?? 0.0));
  }

  void showSaleForm({Sale? sale}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(sale == null ? 'Create Sale' : 'Update Sale'),
          content: SaleForm(
            sale: sale,
            onSave: (updatedSale) {
              if (sale == null) {
                createSale(updatedSale);
              } else {
                updateSale(updatedSale);
              }
            },
          ),
        );
      },
    );
  }

  Future<void> createSale(Sale sale) async {
    try {
      final createdSale = await salesService.createSale(sale);
      setState(() {
        sales.add(createdSale);
        totalSales = calculateTotalSales(); // Recalculate total sales
      });
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error creating sale: $e')));
    }
  }

  Future<void> updateSale(Sale sale) async {
    try {
      final updatedSale = await salesService.updateSale(sale);
      setState(() {
        final index = sales.indexWhere((s) => s.id == updatedSale.id);
        if (index != -1) {
          sales[index] = updatedSale;
          totalSales = calculateTotalSales(); // Recalculate total sales
        }
      });
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error updating sale: $e')));
    }
  }

  Future<void> deleteSale(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this sale?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      try {
        await salesService.deleteSale(id);
        setState(() {
          sales.removeWhere((sale) => sale.id == id);
          totalSales = calculateTotalSales(); // Recalculate total sales
        });
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error deleting sale: $e')));
      }
    }
  }

  void filterSales(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredSales = sales.where((sale) {
      return sale.id.toString().contains(searchQuery) ||
          sale.quantity.toString().contains(searchQuery) ||
          sale.totalPrice.toString().contains(searchQuery);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Management'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => showSaleForm(),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.teal.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Display total sales value
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total Sales: \$${totalSales.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Search Sales',
                  border: OutlineInputBorder(),
                ),
                onChanged: filterSales,
              ),
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredSales.isEmpty
                    ? const Center(child: Text('No sales found.'))
                    : Expanded(
                        child: ListView.builder(
                          itemCount: filteredSales.length,
                          itemBuilder: (context, index) {
                            final sale = filteredSales[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              elevation: 4,
                              child: ListTile(
                                title: Text('Sale ID: ${sale.id}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                    'Quantity: ${sale.quantity}, Total Price: \$${sale.totalPrice}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () => showSaleForm(sale: sale),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () => deleteSale(sale.id!),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}

class SaleForm extends StatefulWidget {
  final Sale? sale;
  final Function(Sale) onSave;

  const SaleForm({super.key, this.sale, required this.onSave});

  @override
  _SaleFormState createState() => _SaleFormState();
}

class _SaleFormState extends State<SaleForm> {
  final _formKey = GlobalKey<FormState>();
  late int quantity;
  late double price;
  late double totalPrice;

  @override
  void initState() {
    super.initState();
    if (widget.sale != null) {
      quantity = widget.sale!.quantity ?? 1;
      price = widget.sale!.price ?? 0.0;
      totalPrice = widget.sale!.totalPrice ?? 0.0;
    } else {
      quantity = 1;
      price = 0.0;
      totalPrice = 0.0;
    }
  }

  void _calculateTotalPrice() {
    totalPrice = quantity * price;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              initialValue: quantity.toString(),
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  quantity = int.tryParse(value) ?? 1;
                  _calculateTotalPrice();
                });
              },
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    int.tryParse(value) == null) {
                  return 'Please enter a valid quantity';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: price.toString(),
              decoration: const InputDecoration(labelText: 'Price per unit'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  price = double.tryParse(value) ?? 0.0;
                  _calculateTotalPrice();
                });
              },
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    double.tryParse(value) == null) {
                  return 'Please enter a valid price';
                }
                return null;
              },
            ),
            Text('Total Price: \$${totalPrice.toStringAsFixed(2)}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  final sale = Sale(
                    id: widget.sale?.id,
                    quantity: quantity,
                    price: price,
                    totalPrice: totalPrice,
                  );
                  widget.onSave(sale);
                }
              },
              child: Text(widget.sale == null ? 'Create Sale' : 'Update Sale'),
            ),
          ],
        ),
      ),
    );
  }
}
