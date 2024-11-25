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
  late bool _isSearching;
  late List<Stock> _filteredStocks;

  @override
  void initState() {
    super.initState();
    _futureStocks = StockService().getStocks();
    _searchController = TextEditingController();
    _isSearching = false;
    _filteredStocks = [];
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
      if (query.isEmpty) {
        _filteredStocks = [];
      } else {
        _filteredStocks = _filteredStocks
            .where((stock) =>
        stock.product?.name.toLowerCase().contains(query.toLowerCase()) ??
            false)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Management'),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_isSearching)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterStocks,
                  decoration: InputDecoration(
                    labelText: 'Search by product name',
                    border: OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                  ),
                ),
              ),
            Expanded(
              child: FutureBuilder<List<Stock>>(
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

                  return PaginatedDataTable(
                    header: const Text(
                      'Stock Overview',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    rowsPerPage: 10,
                    columns: [
                      DataColumn(label: Text('Product')),
                      DataColumn(label: Text('Warehouse')),
                      DataColumn(label: Text('Actions')),
                    ],
                    source: _StockDataSource(
                      context: context,
                      stocks: stocks,
                      onEdit: (stock) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditStockPage(stock: stock),
                          ),
                        );
                      },
                      onDelete: _deleteStock,
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



class _StockDataSource extends DataTableSource {
  final BuildContext context;
  final List<Stock> stocks;
  final Function(Stock) onEdit;
  final Function(int) onDelete;

  _StockDataSource({
    required this.context,
    required this.stocks,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  DataRow getRow(int index) {
    final stock = stocks[index];
    return DataRow(cells: [
      DataCell(Text(stock.product?.name ?? 'N/A')),
      DataCell(Text(stock.wareHouse?.name ?? 'N/A')),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.orange),
            onPressed: () => onEdit(stock),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => onDelete(stock.id!),
          ),
        ],
      )),
    ]);
  }

  @override
  int get rowCount => stocks.length;

  @override
  int get selectedRowCount => 0;

  @override
  bool get isRowCountApproximate => false; // Return false if row count is exact
}

