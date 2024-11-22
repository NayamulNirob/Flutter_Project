import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:merchandise_management_system/models/Customer.dart';
import 'package:merchandise_management_system/services/CustomerService.dart';
import 'package:merchandise_management_system/pages/Add_edit_customer_dialog.dart';

class CustomerManagementPage extends StatefulWidget {
  @override
  _CustomerManagementPageState createState() => _CustomerManagementPageState();
}

class _CustomerManagementPageState extends State<CustomerManagementPage> {
  final CustomerService _customerService = CustomerService();
  List<Customer> _customers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCustomers();
  }

  Future<void> _fetchCustomers() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final customers = await _customerService.fetchCustomers();
      setState(() {
        _customers = customers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackBar('Failed to load buyers.');
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

  void _showAddCustomerDialog() {
    showDialog(
      context: context,
      builder: (context) => AddEditCustomerDialog(onSave: _addCustomer),
    );
  }

  Future<void> _addCustomer(Customer customer) async {
    try {
      await _customerService.addCustomer(customer);
      _fetchCustomers();
      _showSuccessSnackBar('Buyer added successfully.');
    } catch (e) {
      _showErrorSnackBar('Failed to add Buyer.');
    }
  }

  Future<void> _updateCustomer(Customer customer) async {
    try {
      await _customerService.updateCustomer(customer);
      _fetchCustomers();
      _showSuccessSnackBar('Buyer updated successfully.');
    } catch (e) {
      _showErrorSnackBar('Failed to update Buyer.');
    }
  }

  Future<void> _deleteCustomer(int id) async {
    try {
      await _customerService.deleteCustomer(id);
      _fetchCustomers();
      _showSuccessSnackBar('Buyer deleted successfully.');
    } catch (e) {
      _showErrorSnackBar('Failed to delete Buyer.');
    }
  }

  void _showEditCustomerDialog(Customer customer) {
    showDialog(
      context: context,
      builder: (context) => AddEditCustomerDialog(
        customer: customer,
        onSave: _updateCustomer,
      ),
    );
  }

  void _confirmDeleteCustomer(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this buyer?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Delete', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.pop(context);
              _deleteCustomer(id);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buyer Management'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCustomerDialog,
        child: Icon(Icons.add,color: Colors.white,),
        tooltip: 'Add Byuer',
        backgroundColor: Colors.green,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _customers.length,
          itemBuilder: (context, index) {
            final customer = _customers[index];
            return _buildCustomerCard(customer);
          },
        ),
      ),
    );
  }

  Widget _buildCustomerCard(Customer customer) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              customer.name ?? 'No Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildDetailRow('Email:', customer.email),
            _buildDetailRow('Phone:', customer.phone),
            _buildDetailRow('Address:', customer.address),
            _buildDetailRow(
              'Created At:',
              customer.createdAt != null
                  ? DateFormat('dd-MM-yyyy hh:mm a').format(customer.createdAt!)
                  : 'N/A',
            ),
            _buildDetailRow('Organization:', customer.organigation),
            _buildDetailRow('Country:', customer.countryObj?.name),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  label: Text('Edit'),
                  onPressed: () => _showEditCustomerDialog(customer),
                ),
                SizedBox(width: 16),
                TextButton.icon(
                  icon: Icon(Icons.delete, color: Colors.red),
                  label: Text('Delete'),
                  onPressed: () => _confirmDeleteCustomer(customer.id!),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: TextStyle(color: Colors.grey[700]),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
