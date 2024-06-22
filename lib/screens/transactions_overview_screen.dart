import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expensetracker/providers/transactions.dart';
import 'package:expensetracker/providers/budgets.dart';
import 'package:expensetracker/widgets/transactions_list.dart';
import 'package:expensetracker/widgets/new_transaction.dart';
import 'package:expensetracker/screens/set_budget_screen.dart';

class TransactionsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final budgetData = Provider.of<Budgets>(context);
    final currentMonth = DateTime.now();
    final budget = budgetData.getBudgetForMonth(currentMonth);
    final totalExpenses = Provider.of<Transactions>(context).getTotalExpenses();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Expense Tracker'),
          backgroundColor: Colors.blue,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => SetBudgetScreen()),
                  );
                },
                child: Text('Set Monthly Budget'),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                Expanded(child: TransactionsList()),
                Container(
                  color: Colors.pinkAccent,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Total Expenses: \Rs.${totalExpenses.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey[800],
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Monthly Budget: \Rs.${budget?.amount.toStringAsFixed(2) ?? 'Not Set'}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                if (budget != null)
                  Container(
                    color: Colors.green,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Remaining Balance: \Rs.${(budget.amount - totalExpenses).toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            Positioned(
              bottom: 80,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => NewTransaction(),
                  );
                },
                child: Icon(Icons.add, color: Colors.black),
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
