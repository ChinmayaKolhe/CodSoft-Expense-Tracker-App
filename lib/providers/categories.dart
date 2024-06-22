import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:expensetracker/models/category.dart';
class Categories with ChangeNotifier {
  List<Category> _items = [
    Category(id: Uuid().v4(), title: 'Food'),
    Category(id: Uuid().v4(), title: 'Transport'),
    Category(id: Uuid().v4(), title: 'Entertainment'),
    Category(id: Uuid().v4(), title: 'Utilities'),
    Category(id: Uuid().v4(), title: 'Education'),
  ];

  List<Category> get items {
    return [..._items];
  }

  void addCategory(String title) {
    final newCategory = Category(
      id: Uuid().v4(),
      title: title,
    );
    _items.add(newCategory);
    notifyListeners();
  }

  Category? findById(String id) {
    try {
      return _items.singleWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }
}