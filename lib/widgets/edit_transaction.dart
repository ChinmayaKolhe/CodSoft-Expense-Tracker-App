import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:expensetracker/providers/transactions.dart';
import 'package:expensetracker/providers/categories.dart';
import 'package:expensetracker/models/transaction.dart';

class EditTransaction extends StatefulWidget {
  final Transaction transaction;

  EditTransaction({required this.transaction});

  @override
  _EditTransactionState createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late DateTime _selectedDate;
  String? _selectedCategory;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.transaction.title);
    _amountController = TextEditingController(text: widget.transaction.amount.toString());
    _selectedDate = widget.transaction.date;
    _selectedCategory = widget.transaction.category;
    super.initState();
  }

  void _submitData() {
    if (_titleController.text.isEmpty || _amountController.text.isEmpty || _selectedCategory == null) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    Provider.of<Transactions>(context, listen: false).updateTransaction(
      widget.transaction.id,
      enteredTitle,
      enteredAmount,
      _selectedDate,
      _selectedCategory!,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesData = Provider.of<Categories>(context);
    final categories = categoriesData.items;

    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2019),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate == null) {
                        return;
                      }
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    },
                  ),
                ],
              ),
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Category'),
              value: _selectedCategory,
              items: categories.map((cat) {
                return DropdownMenuItem<String>(
                  value: cat.id,
                  child: Text(cat.title),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
            ElevatedButton(
              child: Text('Update Transaction'),
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
