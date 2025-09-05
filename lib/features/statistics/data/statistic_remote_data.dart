import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financetreckerapp/features/expense/data/expense.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StatisticRemoteDataSource {
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
}