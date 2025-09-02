import 'package:financetreckerapp/features/expense/domain/expense.dart';
import 'package:financetreckerapp/features/expense/presentation/cubit/expence_cubit.dart';
import 'package:financetreckerapp/features/expense/presentation/cubit/expence_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ExpensePage extends StatelessWidget {
  const ExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Xarajatlar")),
      body: BlocBuilder<ExpenseCubit, ExpenseState>(
        builder: (context, state) {
          if (state is ExpenseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExpenseLoaded) {
            return ListView.builder(
              itemCount: state.expenses.length,
              itemBuilder: (context, index) {
                final expense = state.expenses[index];
                return ListTile(
                  title: Text("${expense.amount} - ${expense.category}"),
                  subtitle: Text(expense.note),
                );
              },
            );
          } else {
            return const Center(child: Text("Xarajatlar yo'q"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ExpenseCubit>().addExpense(
                Expense(
                  id: DateTime.now().toString(),
                  amount: 20000,
                  category: "Oziq-ovqat",
                  date: DateTime.now(),
                  note: "Non va sut",
                ),
              );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
