import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expensetracker/providers/budgets.dart';

class SetBudgetScreen extends StatefulWidget {
  @override
  _SetBudgetScreenState createState() => _SetBudgetScreenState();
}

class _SetBudgetScreenState extends State<SetBudgetScreen> {
  final _amountController = TextEditingController();

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredAmount = double.parse(_amountController.text);
    if (enteredAmount <= 0) {
      return;
    }
    final currentMonth = DateTime.now();
    final existingBudget = Provider.of<Budgets>(context, listen: false).getBudgetForMonth(currentMonth);

    if (existingBudget != null) {
      Provider.of<Budgets>(context, listen: false).updateBudget(existingBudget.id, enteredAmount);
    } else {
      Provider.of<Budgets>(context, listen: false).addBudget(enteredAmount, currentMonth);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Monthly Budget'),
      ),
      body: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              ElevatedButton(
                child: Text('Set Budget'),
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
