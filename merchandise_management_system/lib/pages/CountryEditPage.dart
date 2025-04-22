import 'package:flutter/material.dart';
import 'package:merchandise_management_system/models/Country.dart';
import 'package:merchandise_management_system/services/CountryService.dart';

class CountryEditPage extends StatefulWidget {
  final Country country;

  const CountryEditPage({required this.country, super.key});

  @override
  _CountryEditPageState createState() => _CountryEditPageState();
}

class _CountryEditPageState extends State<CountryEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _businessController;
  late TextEditingController _saleController;
  late TextEditingController _progressController;
  late TextEditingController _statusController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.country.name);
    _businessController = TextEditingController(text: widget.country.bussiness);
    _saleController = TextEditingController(text: widget.country.sale.toString());
    _progressController=TextEditingController(text:widget.country.progress.toString());
    _statusController=TextEditingController(text: widget.country.status);
  }

  Future<void> _saveCountry() async {
    if (_formKey.currentState!.validate()) {
      // Update country data and call the API to save changes
      Country updatedCountry = Country(
        id: widget.country.id,
        name: _nameController.text,
        bussiness: _businessController.text,
        sale: double.tryParse(_saleController.text) ?? 0.0,
          progress:_progressController.text,
          status:_statusController.text
        // Add other fields as necessary
      );

      await CountryService().updateCountry(updatedCountry, updatedCountry.id);
      Navigator.pop(context, updatedCountry);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Country'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Country Name'),
                validator: (value) => value == null || value.isEmpty ? 'Enter country name' : null,
              ),
              TextFormField(
                controller: _businessController,
                decoration: const InputDecoration(labelText: 'Business'),
                validator: (value) => value == null || value.isEmpty ? 'Enter business details' : null,
              ),
              TextFormField(
                controller: _saleController,
                decoration: const InputDecoration(labelText: 'Sale'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Enter sale amount' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _progressController,
                decoration: const InputDecoration(labelText: 'Progress'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Enter Progress percentage' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(labelText: 'Status'),
                validator: (value) => value == null || value.isEmpty ? 'Change Status' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveCountry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,
                ),
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
