import 'package:flutter/material.dart';
import 'package:merchandise_management_system/models/WareHouse.dart';
import 'package:merchandise_management_system/services/WareHouseService.dart';

class AddEditWarehouseDialog extends StatefulWidget {
  final WareHouse? warehouse;
  final Function (WareHouse) onSave;

  const AddEditWarehouseDialog({super.key, this.warehouse,required this.onSave});

  @override
  State<AddEditWarehouseDialog> createState() => _AddEditWarehouseDialogState();
}

class _AddEditWarehouseDialogState extends State<AddEditWarehouseDialog> {
  final _formKey = GlobalKey<FormState>();
  final WarehouseService _warehouseService = WarehouseService();


  late  String _name;
  late String  _location;
  late int _capacity;
  late String _contact;


  @override
  void initState() {

    _name =widget.warehouse?.name ?? '';
    _location =widget.warehouse?.location ?? '';
    _capacity = widget.warehouse?.capacity ?? 00;
    _contact = widget.warehouse?.contact ?? '';
  }


  void _submitForm(){
    if (_formKey.currentState?.validate()?? false){
      _formKey.currentState?.save();

      final wareHouse = WareHouse(
        id: widget.warehouse?.id,
        name: _name,
        location: _location,
        capacity: _capacity,
        contact: _contact
      );
      widget.onSave(wareHouse);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.warehouse == null ? 'Add Warehouse' : 'Edit Warehouse'),
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
                  initialValue: _location,
                  decoration: InputDecoration(labelText: 'Location'),
                  onSaved: (value) => _location = value ?? '',
                  validator: (value) =>
                  value?.isEmpty == true ? 'Location is required' : null,
                ),
                TextFormField(
                  initialValue: _contact,
                  decoration: InputDecoration(labelText: 'Contact'),
                  onSaved: (value) => _contact = value ?? '',
                  validator: (value) =>
                  value?.isEmpty == true ? 'Contact is required' : null,
                ),
                TextFormField(
                  initialValue: _capacity.toString(),
                  decoration: InputDecoration(labelText: 'Capacity'),
                  onSaved: (value) => _capacity = int.tryParse(value ?? '0') ?? 0,
                  validator: (value) =>
                  value?.isEmpty == true ? 'Capacity is required' : null,
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
