import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financetreckerapp/features/expense/data/expense_model.dart';


class ExpenseDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addExpense(ExpenseModel expense) async {
    await firestore.collection('expenses').doc(expense.id).set(expense.toMap());
  }

  Future<void> updateExpense(ExpenseModel expense) async {
    await firestore.collection('expenses').doc(expense.id).update(expense.toMap());
  }

  Future<void> deleteExpense(String id) async {
    await firestore.collection('expenses').doc(id).delete();
  }

  Future<List<ExpenseModel>> getExpenses() async {
    final snapshot = await firestore.collection('expenses').get();
    return snapshot.docs.map((doc) => ExpenseModel.fromMap(doc.data())).toList();
  }
}
