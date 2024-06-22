import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expensetracker/providers/transactions.dart';
import 'package:expensetracker/providers/categories.dart';
import 'package:expensetracker/screens/transactions_overview_screen.dart';
import 'package:expensetracker/providers/budgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Transactions()),
        ChangeNotifierProvider(create: (context) => Categories()),
        ChangeNotifierProvider(create: (_) => Budgets()),
      ],
      child: MaterialApp(
        title: 'Expense Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,

        ),
        home: TransactionsOverviewScreen(),
      ),
    );
  }
}
