import 'package:financetreckerapp/features/expense/presentation/pages/expenses.dart';
import 'package:financetreckerapp/features/expense/presentation/pages/statistics_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final _pages = const [ExpensesPage(), StatisticsPage()];
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
        ],
      ),
    );
  }
}
