import 'package:financetreckerapp/features/expense/domain/expense.dart';
import 'package:fl_chart/fl_chart.dart';

abstract class ExpenseState {}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<Expense> expenses;
  ExpenseLoaded(this.expenses);
}

class ExpensesLoaded extends ExpenseState {
  final List<Expense> expenses;
  final List<FlSpot> spots;
  ExpensesLoaded({required this.expenses, required this.spots});
}

class ExpenseError extends ExpenseState {
  final String e;
  ExpenseError(this.e);
}
