import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:expensetracker/models/budget.dart';

class Budgets with ChangeNotifier {
  List<Budget> _items = [];

  List<Budget> get items {
    return [..._items];
  }

  Budget? getBudgetForMonth(DateTime month) {
    try {
      return _items.firstWhere(
            (budget) => budget.month.year == month.year && budget.month.month == month.month,
      );
    } catch (e) {
      return null;
    }
  }

  void addBudget(double amount, DateTime month) {
    final newBudget = Budget(
      id: Uuid().v4(),
      amount: amount,
      month: month,
    );
    _items.add(newBudget);
    notifyListeners();
  }

  void updateBudget(String id, double amount) {
    final budgetIndex = _items.indexWhere((budget) => budget.id == id);
    if (budgetIndex >= 0) {
      _items[budgetIndex] = Budget(
        id: id,
        amount: amount,
        month: _items[budgetIndex].month,
      );
      notifyListeners();
    }
  }
}
