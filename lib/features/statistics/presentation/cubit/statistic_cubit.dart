import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financetreckerapp/features/statistics/data/expence_model.dart';

import 'package:financetreckerapp/features/statistics/data/statistic_remote_data.dart';
import 'package:financetreckerapp/features/statistics/presentation/cubit/statistic_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticCubit extends Cubit<StatisticState> {
  StatisticCubit(this.dataSource) : super(StatisticInitial());
  StatisticRemoteDataSource dataSource;
  Future<void> loadExpenses() async {
    emit(StatisticLoading());
    final expenses = await dataSource.getEx();

    print("Load bo'ldi ----");
    print("EXPENSES - $expenses");
    emit(StatisticLoaded(expenses,));
  }

  Future<void> loadLast30DaysExpenses() async {
    emit(StatisticLoading());

    try {
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

      final expenses = snapshot.docs
          .map((doc) => ExpenseModel.fromJson(doc.data(), doc.id))
          .toList();

      //dayly
      Map<DateTime, double> dailyTotals = {};
      for (var expense in expenses) {
        final date = DateTime(
          expense.date.year,
          expense.date.month,
          expense.date.day,
        );
        dailyTotals[date] = (dailyTotals[date] ?? 0) + expense.amount;
      }

      //  Grafik uchun spots
      final sortedDates = dailyTotals.keys.toList()..sort();
      List<FlSpot> spots = [];
      for (int i = 0; i < sortedDates.length; i++) {
        final date = sortedDates[i];
        final amount = dailyTotals[date]!;
        spots.add(FlSpot(i.toDouble(), amount));
      }
      print("CUBIT SPOT - $spots");
      emit(StatisticSpotLoaded(expenses: expenses, spots: spots));
    } catch (e) {
      emit(StatisticError(e.toString()));
    }
  }
}
