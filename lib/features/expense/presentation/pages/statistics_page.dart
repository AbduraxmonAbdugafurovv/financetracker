import 'package:financetreckerapp/features/expense/domain/expense.dart';
import 'package:financetreckerapp/features/expense/presentation/cubit/expence_cubit.dart';
import 'package:financetreckerapp/features/expense/presentation/cubit/expence_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Statistika")),
      body: BlocBuilder<ExpenseCubit, ExpenseState>(
        builder: (context, state) {
          if (state is ExpenseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExpenseLoaded) {
            if (state.expenses.isEmpty) {
              return const Center(child: Text("Xarajatlar mavjud emas"));
            }

            final data = _groupByCategory(state.expenses);

            return Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: PieChart(
                    PieChartData(
                      sections: data.entries.map((entry) {
                        return PieChartSectionData(
                          value: entry.value,
                          title: "${entry.key}\n${entry.value.toInt()} so'm",
                          radius: 80,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is ExpenseError) {
            return Center(child: Text("Xato: ${state.e}"));
          }
          return const SizedBox();
        },
      ),
    );
  }

  Map<String, double> _groupByCategory(List<Expense> expenses) {
    final Map<String, double> result = {};
    for (final e in expenses) {
      result[e.category] = (result[e.category] ?? 0) + e.amount;
    }
    return result;
  }
}

