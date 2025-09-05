import 'dart:io';
import 'package:financetreckerapp/features/expense/data/expense.dart';
import 'package:financetreckerapp/features/expense/data/expense_data_source.dart';
import 'package:financetreckerapp/features/expense/data/expense_local_db.dart';
import 'package:financetreckerapp/features/expense/domain/expense.dart';
import 'package:financetreckerapp/features/expense/domain/expense_repository.dart';


class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseRemoteDataSource remote;
  final ExpenseLocalDataSource local;

  ExpenseRepositoryImpl({
    required this.remote,
    required this.local,
  });

  Future<bool> _hasInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> addExpense(Expense expense) async {
    final model = ExpenseModel(
      id: expense.id,
      amount: expense.amount,
      category: expense.category,
      date: expense.date,
      note: expense.note,
    );

    // if (await _hasInternet()) {
    //   await remote.addExpense(model);
    // }
    await local.addExpense(model);
  }

  @override
  Future<List<Expense>> getExpenses() async {
    if (await _hasInternet()) {
      final remoteExpenses = await remote.getEx();
      await local.cacheExpenses(remoteExpenses);
      return remoteExpenses;
    } else {
      return await local.getCachedExpenses();
    }
  }

  @override
  Future<void> updateExpense(Expense expense) async {
    final model = ExpenseModel(
      id: expense.id,
      amount: expense.amount,
      category: expense.category,
      date: expense.date,
      note: expense.note,
    );

    if (await _hasInternet()) {
      await remote.updateExpense(model);
    }
    await local.updateExpense(model);
  }

  @override
  Future<void> deleteExpense(String id) async {
    if (await _hasInternet()) {
      await remote.deleteExpense(id);
    }
    await local.deleteExpense(id);
  }
}
