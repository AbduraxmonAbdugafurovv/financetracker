import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financetreckerapp/features/expense/domain/expense.dart';

class ExpenseModel extends Expense {
  ExpenseModel({
    required super.id,
    required super.amount,
    required super.category,
    required super.date,
    required super.note,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json, String id) {
    return ExpenseModel(
      id: id,
      amount: json['amount'],
      category: json['category'],
      date: json['date'] is Timestamp
          ? (json['date'] as Timestamp).toDate()
          : DateTime.parse(json['date'] as String),
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "category": category,
      "date": date,
      "note": note,
    };
  }
}
