import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financetreckerapp/features/expense/data/expense_model.dart';

class ExpenseRemoteDataSource {
  final _db = FirebaseFirestore.instance.collection("expenses");

  Future<void> addExpense(ExpenseModel expense) async {
    await _db.add(expense.toJson());
  }

  Future<List<ExpenseModel>> getExpenses() async {
    final snapshot = await _db.get();
    return snapshot.docs
        .map((doc) => ExpenseModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<void> updateExpense(ExpenseModel expense) async {
    await _db.doc(expense.id).update(expense.toJson());
  }

  Future<void> deleteExpense(String id) async {
    await _db.doc(id).delete();
  }
}
