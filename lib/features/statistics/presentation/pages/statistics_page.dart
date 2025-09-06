import 'package:financetreckerapp/features/statistics/domain/expense.dart';
import 'package:financetreckerapp/features/statistics/presentation/cubit/statistic_cubit.dart';
import 'package:financetreckerapp/features/statistics/presentation/cubit/statistic_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<StatisticCubit>().loadExpenses();
    context.read<StatisticCubit>().loadLast30DaysExpenses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Statistika")),
      body: BlocBuilder<StatisticCubit, StatisticState>(
        builder: (context, state) {
          if (state is StatisticLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StatisticLoaded || state is StatisticSpotLoaded) {
            final expenses = state is StatisticSpotLoaded
                ? state.expenses
                : (state as StatisticLoaded).expenses;

            if (expenses.isEmpty) {
              return const Center(child: Text("Xarajatlar mavjud emas"));
            }

            //  1. Oylik jami
            final total = expenses.fold<double>(0, (sum, e) => sum + e.amount);

            //  2. Kategoriya bo‘yicha PieChart
            final categoryData = _groupByCategory(expenses);

            //  3. Oxirgi 30 kun line chart
            final spots = state is StatisticSpotLoaded
                ? state.spots
                : <FlSpot>[];
            print("SPOTS __ $spots");
            print("state spot --- ${state}");

            //  4. Eng ko‘p kategoriya
            final topCategory = categoryData.entries.isNotEmpty
                ? categoryData.entries.reduce(
                    (a, b) => a.value > b.value ? a : b,
                  )
                : null;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Oylik jami
                    Text(
                      "Oylik jami: ${total.toStringAsFixed(0)} so'm",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Pie Chart
                    SizedBox(
                      height: 250,
                      child: PieChart(
                        PieChartData(
                          sections: categoryData.entries.map((entry) {
                            return PieChartSectionData(
                              value: entry.value,
                              title:
                                  "${entry.key}\n${entry.value.toInt()} so'm",
                              radius: 80,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Line Chart
                    if (spots.isNotEmpty) ...[
                      const Text(
                        "Oxirgi 30 kun grafigi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 250,
                        child: LineChart(
                          LineChartData(
                            lineBarsData: [
                              LineChartBarData(
                                spots: spots,
                                isCurved: true,
                                barWidth: 3,
                                belowBarData: BarAreaData(show: true),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],

                    // Eng ko‘p kategoriya
                    if (topCategory != null)
                      Text(
                        "Eng ko‘p xarajat qilingan kategoriya: "
                        "${topCategory.key} (${topCategory.value.toInt()} so'm)",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),
            );
          } else if (state is StatisticError) {
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
