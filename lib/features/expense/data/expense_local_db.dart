import 'package:financetreckerapp/features/expense/data/expense.dart';
import 'package:hive/hive.dart';

class ExpenseLocalDataSource {
  final Box<ExpenseModel> box;

  ExpenseLocalDataSource(this.box);

  Future<void> cacheExpenses(List<ExpenseModel> expenses) async {
    await box.clear();
    for (var e in expenses) {
      await box.put(e.id, e);
    }
  }

  Future<List<ExpenseModel>> getCachedExpenses() async {
    return box.values.toList();
  }

  Future<void> addExpense(ExpenseModel expense) async {
    await box.put(expense.id, expense);
  }

  Future<void> updateExpense(ExpenseModel expense) async {
    await box.put(expense.id, expense);
  }

  Future<void> deleteExpense(String id) async {
    await box.delete(id);
  }
}
