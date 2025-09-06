import 'package:financetreckerapp/features/expense/presentation/cubit/expence_cubit.dart';
import 'package:financetreckerapp/features/expense/presentation/pages/expenses.dart';
import 'package:financetreckerapp/features/statistics/presentation/pages/statistics_page.dart';
import 'package:financetreckerapp/features/profile/presentation/page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final _pages = const [ExpensesPage(), StatisticsPage(), ProfilePage()];

  @override
  void initState() {
    // TODO: implement initState
    context.read<ExpenseCubit>().loadExpenses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Xarajatlar"),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: "Statistika",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
