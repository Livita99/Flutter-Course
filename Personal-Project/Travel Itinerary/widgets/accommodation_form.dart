import 'package:flutter/material.dart';
import 'package:flutter_workspace/Travel%20Itinerary/models/accommodation.dart';
import 'package:intl/intl.dart';

class AccommodationForm extends StatefulWidget {
  const AccommodationForm({super.key});

  @override
  State<AccommodationForm> createState() => _AccommodationFormState();
}

class _AccommodationFormState extends State<AccommodationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  DateTime? selectedCheckInDate;
  DateTime? selectedCheckOutDate;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          selectedCheckInDate = picked;
        } else {
          selectedCheckOutDate = picked;
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newAccommodation = Accommodation(
        name: _nameController.text,
        checkInDate: selectedCheckInDate!,
        checkOutDate: selectedCheckOutDate!,
        address: _addressController.text,
      );
      Navigator.pop(context, newAccommodation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Accommodation'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Accommodation Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an accommodation name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        selectedCheckInDate == null
                            ? 'Select Check-In Date'
                            : DateFormat('dd/MM/yyyy')
                                .format(selectedCheckInDate!),
                        style: TextStyle(
                          fontSize: 16,
                          color: selectedCheckInDate == null
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, true),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        selectedCheckOutDate == null
                            ? 'Select Check-Out Date'
                            : DateFormat('dd/MM/yyyy')
                                .format(selectedCheckOutDate!),
                        style: TextStyle(
                          fontSize: 16,
                          color: selectedCheckOutDate == null
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, false),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: Text('Add Accommodation'),
        ),
      ],
    );
  }
}
