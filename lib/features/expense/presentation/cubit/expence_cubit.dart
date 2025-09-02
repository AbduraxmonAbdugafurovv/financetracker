import 'package:financetreckerapp/features/expense/domain/expense.dart';
import 'package:financetreckerapp/features/expense/domain/expense_repository.dart';
import 'package:financetreckerapp/features/expense/presentation/cubit/expence_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final ExpenseRepository repository;

  ExpenseCubit(this.repository) : super(ExpenseInitial());

  Future<void> loadExpenses() async {
    emit(ExpenseLoading());
    try {
      final expenses = await repository.getExpenses();
      emit(ExpenseLoaded(expenses));
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> addExpense(Expense expense) async {
    await repository.addExpense(expense);
    loadExpenses();
  }

  Future<void> updateExpense(Expense expense) async {
    await repository.updateExpense(expense);
    loadExpenses();
  }

  Future<void> deleteExpense(String id) async {
    await repository.deleteExpense(id);
    loadExpenses();
  }
}
