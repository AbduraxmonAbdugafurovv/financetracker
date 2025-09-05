import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financetreckerapp/features/expense/data/expense_data_source.dart';
import 'package:financetreckerapp/features/expense/data/expense.dart';
import 'package:financetreckerapp/features/expense/domain/expense.dart';
import 'package:financetreckerapp/features/expense/presentation/cubit/expence_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final ExpenseRemoteDataSource dataSource;

  ExpenseCubit(this.dataSource) : super(ExpenseInitial());

  Future<void> loadExpenses() async {
    emit(ExpenseLoading());
    final expenses = await dataSource.getEx();

    print("Load bo'ldi ----");
    print("EXPENSES - $expenses");
    emit(ExpenseLoaded(expenses));
  }

  Future<void> addExpense(Expense expense) async {
    await dataSource.addEx(
      ExpenseModel(
        id: expense.id,
        amount: expense.amount,
        category: expense.category,
        date: expense.date,
        note: expense.note,
      ),
    );
    print("ADD to exp");
    loadExpenses();
  }

  Future<void> updateExpense(Expense expense) async {
    await dataSource.updateExpense(
      ExpenseModel(
        id: expense.id,
        amount: expense.amount,
        category: expense.category,
        date: expense.date,
        note: expense.note,
      ),
    );
    loadExpenses();
  }

  Future<void> deleteExpense(String id) async {
    await dataSource.deleteExpense(id);
    loadExpenses();
  }

}
