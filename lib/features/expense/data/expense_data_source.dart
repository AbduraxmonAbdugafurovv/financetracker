import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financetreckerapp/features/expense/data/expense.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExpenseRemoteDataSource {
  final _db = FirebaseFirestore.instance.collection("expenses");
  Future addEx(ExpenseModel expense) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("expenses")
        .add(expense.toJson());
  }

  // Future<void> addExpense(ExpenseModel expense) async {
  //   await _db.doc(expense.id).set(expense.toJson());
  // }

  // Future<List<ExpenseModel>> getExpenses() async {
  //   final snapshot = await _db.get();
  //   return snapshot.docs
  //       .map((doc) => ExpenseModel.fromJson(doc.data(), doc.id))
  //       .toList();
  // }

  Future getEx() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("expenses")
        .get();
    print(" SNAPSHOOOT ___ $snapshot");
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

  Future getbyMonth() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));

    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("expenses")
        .where("date", isGreaterThanOrEqualTo: thirtyDaysAgo)
        .orderBy("date")
        .get();

    final expenses = snapshot.docs.map((doc) {
      final data = doc.data();
      return ExpenseModel.fromJson(data, doc.id);
    }).toList();
  }
}
