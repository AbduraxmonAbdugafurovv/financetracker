import 'package:financetreckerapp/features/expense/domain/expense.dart';

abstract class ExpenseRepository {
  Future<void> addExpense(Expense expense);
  Future<void> updateExpense(Expense expense);
  Future<void> deleteExpense(String id);
  Future<List<Expense>> getExpenses();
}
