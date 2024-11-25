import 'package:flutter/material.dart';
import 'package:merchandise_management_system/models/Stock.dart';
import 'package:merchandise_management_system/services/StockService.dart';
import 'package:merchandise_management_system/pages/EditStockPage.dart';

class StockManagementPage extends StatefulWidget {
  const StockManagementPage({Key? key}) : super(key: key);

  @override
  State<StockManagementPage> createState() => _StockManagementPageState();
}

class _StockManagementPageState extends State<StockManagementPage> {
  late Future<List<Stock>> _futureStocks;
  late TextEditingController _searchController;
  bool _isSearching = false;
  List<Stock> _filteredStocks = [];

  @override
  void initState() {
    super.initState();
    _futureStocks = StockService().getStocks();
    _searchController = TextEditingController();
  }

  Future<void> _reloadStocks() async {
    setState(() {
      _futureStocks = StockService().getStocks();
    });
  }

  Future<void> _deleteStock(int id) async {
    try {
      await StockService().deleteStock(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Stock deleted successfully')),
      );
      _reloadStocks();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete stock: $e')),
      );
    }
  }

  void _filterStocks(String query) {
    setState(() {
      _filteredStocks = query.isEmpty
          ? []
          : _filteredStocks
          .where((stock) =>
      stock.product?.name.toLowerCase().contains(query.toLowerCase()) ?? false)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !_isSearching
            ? const Text('Stock Management')
            : TextField(
          controller: _searchController,
          autofocus: true,
          onChanged: _filterStocks,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) _searchController.clear();
              });
            },
          ),
        ],
        backgroundColor: Colors.deepOrange,
      ),
      body: FutureBuilder<List<Stock>>(
        future: _futureStocks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No stocks available'));
          }

          final stocks = _isSearching ? _filteredStocks : snapshot.data!;

          return ListView.builder(
            itemCount: stocks.length,
            itemBuilder: (context, index) {
              final stock = stocks[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  title: Text(stock.product?.name ?? 'N/A'),
                  subtitle: Text('Warehouse: ${stock.wareHouse?.name ?? 'N/A'}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditStockPage(stock: stock),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteStock(stock.id!),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
