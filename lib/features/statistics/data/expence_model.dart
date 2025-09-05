import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financetreckerapp/features/statistics/domain/expense.dart';
import 'package:hive/hive.dart';

// part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends Expense {
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final double amount;

  @HiveField(2)
  @override
  final String category;

  @HiveField(3)
  @override
  final DateTime date;

  @HiveField(4)
  @override
  final String note;

  ExpenseModel({
    required this.id,
    required this.amount,
    required this.category,
    required this.date,
    required this.note,
  }) : super(id: id, amount: amount, category: category, date: date, note: note);

  // Firestore uchun
  factory ExpenseModel.fromJson(Map<String, dynamic> json, String docId) {
    return ExpenseModel(
      id: docId,
      amount: (json['amount'] as num).toDouble(),
      category: json['category'],
      date: (json['date'] as Timestamp).toDate(),
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
