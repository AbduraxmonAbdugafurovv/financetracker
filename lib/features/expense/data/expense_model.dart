

import 'package:financetreckerapp/features/expense/domain/expense.dart';

class ExpenseModel extends Expense {
  ExpenseModel({
    required super.id,
    required super.amount,
    required super.category,
    required super.date,
    required super.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
      'note': note,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'],
      amount: (map['amount'] as num).toDouble(),
      category: map['category'],
      date: DateTime.parse(map['date']),
      note: map['note'],
    );
  }
}
