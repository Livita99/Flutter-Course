import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key, required this.onCreated});

  final Function(Expense) onCreated;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  final List<Category> _dropdownItems = Category.values;

  Category? _selectedCategory;
  DateTime? _selectedDate;

  String get title => _titleController.text;

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void onCancel() {
    // Close modal
    Navigator.pop(context);
  }

  void onAdd() {
    // 1- Get the values from inputs
    String title = _titleController.text;
    double amount = double.parse(_valueController.text);

    if (_selectedCategory == null || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select a category and date'),
            duration: Duration(seconds: 3)),
      );
      return;
    }

    Category category = _selectedCategory!;
    DateTime date = _selectedDate!;

    // 2- Create the expense
    Expense expense =
        Expense(title: title, amount: amount, date: date, category: category);

    // 3- Ask the parent to add the expense
    widget.onCreated(expense);

    // 4- Close modal
    Navigator.pop(context);
  }

  void onChanged(Category? newValue) {
    setState(() {
      _selectedCategory = newValue!;
    });
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    controller: _valueController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      prefix: Text('\$ '),
                      label: Text('Amount'),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  _selectedDate == null
                      ? 'No date selected'
                      : 'Selected Date: ${DateFormat('dd-MM-yyyy').format(_selectedDate!)}',
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  onPressed: () => _pickDate(context),
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  value: _selectedCategory,
                  onChanged: onChanged,
                  items: _dropdownItems.map((Category category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(
                          category.toString().split('.').last.toUpperCase()),
                    );
                  }).toList(),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: onCancel,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: onAdd,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[100],
                  ),
                  child: const Text('Save Expense'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
