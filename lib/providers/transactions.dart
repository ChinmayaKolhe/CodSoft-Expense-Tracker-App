import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:expensetracker/models/transaction.dart';

class Transactions with ChangeNotifier {
  List<Transaction> _items = [];

  List<Transaction> get items {
    return [..._items];
  }

  void addTransaction(String title, double amount, DateTime date, String category) {
    final newTransaction = Transaction(
      id: Uuid().v4(),
      title: title,
      amount: amount,
      date: date,
      category: category,
    );
    _items.add(newTransaction);
    notifyListeners();
  }

  void updateTransaction(String id, String title, double amount, DateTime date, String category) {
    final txIndex = _items.indexWhere((tx) => tx.id == id);
    if (txIndex >= 0) {
      _items[txIndex] = Transaction(
        id: id,
        title: title,
        amount: amount,
        date: date,
        category: category,
      );
      notifyListeners();
    }
  }

  void deleteTransaction(String id) {
    _items.removeWhere((tx) => tx.id == id);
    notifyListeners();
  }

  double getTotalExpenses() {
    return _items.fold(0.0, (sum, item) => sum + item.amount);
  }
}
