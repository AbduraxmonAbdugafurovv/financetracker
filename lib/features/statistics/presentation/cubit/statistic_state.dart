
import 'package:financetreckerapp/features/statistics/domain/expense.dart';
import 'package:fl_chart/fl_chart.dart';

abstract class StatisticState {}

class StatisticInitial extends StatisticState {}

class StatisticLoading extends StatisticState {}



class StatisticLoaded extends StatisticState {
  final List<Expense> expenses;

  StatisticLoaded(this.expenses, );
}
class StatisticSpotLoaded extends StatisticState {
  final List<Expense> expenses;
  final List<FlSpot> spots;
  StatisticSpotLoaded({required this.expenses, required this.spots});
}

class StatisticError extends StatisticState {
  final String e;
  StatisticError(this.e);
}
