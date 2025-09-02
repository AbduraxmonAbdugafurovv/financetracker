import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financetreckerapp/features/expense/domain/expense.dart';
import 'package:financetreckerapp/features/expense/domain/expense_repository.dart';


class FirestoreExpenseRepository implements ExpenseRepository {
  final _db = FirebaseFirestore.instance.collection("expenses");

  @override
  Future<void> addExpense(Expense expense) async {
    await _db.doc(expense.id).set({
      "amount": expense.amount,
      "category": expense.category,
      "date": expense.date.toIso8601String(),
      "note": expense.note,
    });
  }

  @override
  Future<List<Expense>> getExpenses() async {
    final snapshot = await _db.get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Expense(
        id: doc.id,
        amount: data["amount"],
        category: data["category"],
        date: DateTime.parse(data["date"]),
        note: data["note"],
      );
    }).toList();
  }

  @override
  Future<void> updateExpense(Expense expense) async {
    await _db.doc(expense.id).update({
      "amount": expense.amount,
      "category": expense.category,
      "date": expense.date.toIso8601String(),
      "note": expense.note,
    });
  }

  @override
  Future<void> deleteExpense(String id) async {
    await _db.doc(id).delete();
  }
}
