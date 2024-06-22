import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:expensetracker/providers/transactions.dart';
import 'package:expensetracker/providers/categories.dart';


class NewTransaction extends StatefulWidget {
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String? _selectedCategory;

  void _submitData() {
    if (_titleController.text.isEmpty || _amountController.text.isEmpty || _selectedCategory == null) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    Provider.of<Transactions>(context, listen: false)
        .addTransaction(enteredTitle, enteredAmount, _selectedDate, _selectedCategory!);

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
                        initialDate: DateTime.now(),
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
              child: Text('Add Transaction'),
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
