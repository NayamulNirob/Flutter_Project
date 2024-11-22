import 'package:flutter/material.dart';
import 'package:merchandise_management_system/models/Country.dart';
import 'package:merchandise_management_system/models/Customer.dart';
import 'package:merchandise_management_system/services/CountryService.dart';

class AddEditCustomerDialog extends StatefulWidget {
  final Customer? customer;
  final Function(Customer) onSave;

  const AddEditCustomerDialog({Key? key, this.customer, required this.onSave})
      : super(key: key);

  @override
  _AddEditCustomerDialogState createState() => _AddEditCustomerDialogState();
}

class _AddEditCustomerDialogState extends State<AddEditCustomerDialog> {
  final _formKey = GlobalKey<FormState>();
  final CountryService _countryService = CountryService();

  late Future<List<CountryObj>> _futureCountries;

  // Form field values
  late String _name;
  late String _email;
  late String _phone;
  late String _address;
  late String? _contactPerson;
  late String? _organigation;
  CountryObj? _selectedCountry;

  @override
  void initState() {
    super.initState();

    // Initialize form field values
    _name = widget.customer?.name ?? '';
    _email = widget.customer?.email ?? '';
    _phone = widget.customer?.phone ?? '';
    _address = widget.customer?.address ?? '';
    _contactPerson = widget.customer?.contactPerson ?? '';
    _organigation = widget.customer?.organigation ?? '';
    _selectedCountry = widget.customer?.countryObj;

    // Load countries
    _futureCountries = _loadCountries();
  }

  Future<List<CountryObj>> _loadCountries() async {
    try {
      final countries = await _countryService.fetchCountries();
      return countries
          .map((country) => CountryObj(
        id: country.id,
        name: country.name,
      ))
          .toList();
    } catch (e) {
      // Handle errors (e.g., network or parsing errors)
      return [];
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final customer = Customer(
        id: widget.customer?.id,
        name: _name,
        email: _email,
        phone: _phone,
        address: _address,
        contactPerson: _contactPerson,
        organigation: _organigation,
        countryObj: _selectedCountry,
        createdAt: widget.customer?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      widget.onSave(customer);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customer == null ? 'Add Customer' : 'Edit Customer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: _name,
                  decoration: InputDecoration(labelText: 'Name'),
                  onSaved: (value) => _name = value ?? '',
                  validator: (value) =>
                  value?.isEmpty == true ? 'Name is required' : null,
                ),
                TextFormField(
                  initialValue: _email,
                  decoration: InputDecoration(labelText: 'Email'),
                  onSaved: (value) => _email = value ?? '',
                  validator: (value) =>
                  value?.isEmpty == true ? 'Email is required' : null,
                ),
                TextFormField(
                  initialValue: _phone,
                  decoration: InputDecoration(labelText: 'Phone'),
                  onSaved: (value) => _phone = value ?? '',
                  validator: (value) =>
                  value?.isEmpty == true ? 'Phone is required' : null,
                ),
                TextFormField(
                  initialValue: _address,
                  decoration: InputDecoration(labelText: 'Address'),
                  onSaved: (value) => _address = value ?? '',
                  validator: (value) =>
                  value?.isEmpty == true ? 'Address is required' : null,
                ),
                TextFormField(
                  initialValue: _contactPerson,
                  decoration: InputDecoration(labelText: 'Contact Person'),
                  onSaved: (value) => _contactPerson = value,
                ),
                TextFormField(
                  initialValue: _organigation,
                  decoration: InputDecoration(labelText: 'Organization'),
                  onSaved: (value) => _organigation = value,
                ),
                FutureBuilder<List<CountryObj>>(
                  future: _futureCountries,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error loading countries');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No countries available');
                    }

                    return DropdownButtonFormField<CountryObj>(
                      value: _selectedCountry,
                      items: snapshot.data!
                          .map((country) => DropdownMenuItem<CountryObj>(
                        value: country,
                        child: Text(country.name ?? ''),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCountry = value;
                        });
                      },
                      decoration: InputDecoration(labelText: 'Country'),
                      validator: (value) => value == null
                          ? 'Please select a country'
                          : null,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        child: Icon(Icons.save),
      ),
    );
  }
}
