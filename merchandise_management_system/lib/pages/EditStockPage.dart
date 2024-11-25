import 'package:flutter/material.dart';
import 'package:merchandise_management_system/models/Stock.dart';
import 'package:merchandise_management_system/services/StockService.dart';

class EditStockPage extends StatefulWidget {
  final Stock stock;

  const EditStockPage({Key? key, required this.stock}) : super(key: key);

  @override
  State<EditStockPage> createState() => _EditStockPageState();
}

class _EditStockPageState extends State<EditStockPage> {
  final _formKey = GlobalKey<FormState>();
  int? _quantity;

  Future<void> _updateStock() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await StockService().updateStock(
          widget.stock.id!,
          Stock(quantity: _quantity),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Stock updated successfully')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update stock: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Stock'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.stock.quantity.toString(),
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || int.tryParse(value) == null) {
                    return 'Please enter a valid quantity';
                  }
                  return null;
                },
                onSaved: (value) {
                  _quantity = int.parse(value!);
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updateStock,
                child: const Text('Update Stock'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
