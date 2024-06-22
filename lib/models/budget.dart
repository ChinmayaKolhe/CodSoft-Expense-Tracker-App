import 'package:flutter/foundation.dart';

class Budget {
  final String id;
  final double amount;
  final DateTime month;

  Budget({
    required this.id,
    required this.amount,
    required this.month,
  });
}
