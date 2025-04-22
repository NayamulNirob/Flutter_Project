import 'package:flutter/material.dart';
import 'package:merchandise_management_system/models/WareHouse.dart';
import 'package:merchandise_management_system/pages/Add_Edit_Warehouse_Dialog.dart';
import 'package:merchandise_management_system/services/WareHouseService.dart';

class WarehouseMgmtPage extends StatefulWidget {
  const WarehouseMgmtPage({super.key});

  @override
  State<WarehouseMgmtPage> createState() => _WarehouseMgmtPageState();
}

class _WarehouseMgmtPageState extends State<WarehouseMgmtPage> {
  final WarehouseService _warehouseService = WarehouseService();
  List<WareHouse> _warehouses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWarehouses();
  }

  Future<void> _fetchWarehouses() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final warehouses = await _warehouseService.fetchWareHouses();
      setState(() {
        _warehouses = warehouses;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackBar('Failed to load warehouses.');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  void _showAddWarehouseDialog() {
    showDialog(
      context: context,
      builder: (context) => AddEditWarehouseDialog(onSave: _addWarehouse),
    );
  }

  Future<void> _addWarehouse(WareHouse warehouse) async {
    try {
      await _warehouseService.addWareHouse(warehouse);
      _fetchWarehouses();
      _showSuccessSnackBar('Warehouse added successfully.');
    } catch (e) {
      _showErrorSnackBar('Failed to add warehouse.');
    }
  }

  Future<void> _updateWarehouse(WareHouse warehouse) async {
    try {
      await _warehouseService.updateWareHouse(warehouse);
      _fetchWarehouses();
      _showSuccessSnackBar('Warehouse updated successfully.');
    } catch (e) {
      _showErrorSnackBar('Failed to update warehouse.');
    }
  }

  Future<void> _deleteWarehouse(int id) async {
    try {
      await _warehouseService.deleteWareHouse(id);
      _fetchWarehouses();
      _showSuccessSnackBar('Warehouse deleted successfully.');
    } catch (e) {
      _showErrorSnackBar('Failed to delete warehouse.');
    }
  }

  void _showEditWarehouseDialog(WareHouse warehouse) {
    showDialog(
      context: context,
      builder: (context) => AddEditWarehouseDialog(
        warehouse: warehouse,
        onSave: _updateWarehouse,
      ),
    );
  }

  void _confirmDeleteWarehouse(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this warehouse?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.pop(context);
              _deleteWarehouse(id);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _refreshWarehouses() async {
    await _fetchWarehouses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Warehouse Management',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      backgroundColor: Colors.grey[200],
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _warehouses.isEmpty
          ? const Center(child: Text('No warehouses available'))
          : RefreshIndicator(
        onRefresh: _refreshWarehouses,
        child: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: _warehouses.length,
          itemBuilder: (context, index) {
            final warehouse = _warehouses[index];
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            warehouse.name ?? 'Unnamed Warehouse',
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
                              icon: const Icon(Icons.edit,
                                  color: Colors.blue),
                              onPressed: () =>
                                  _showEditWarehouseDialog(warehouse),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.red),
                              onPressed: () =>
                                  _confirmDeleteWarehouse(
                                      warehouse.id!),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Contact: ${warehouse.contact ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Capacity: ${warehouse.capacity ?? 'Unknown'}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Location: ${warehouse.location ?? 'Unknown'}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.indigo,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddWarehouseDialog,
        backgroundColor: Colors.deepOrangeAccent,
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
