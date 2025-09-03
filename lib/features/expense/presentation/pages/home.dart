import 'package:financetreckerapp/features/expense/presentation/cubit/expence_cubit.dart';
import 'package:financetreckerapp/features/expense/presentation/cubit/expence_state.dart';
import 'package:financetreckerapp/features/expense/presentation/widgets/form.dart';
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
                final exp = state.expenses[index];
                return ListTile(
                  title: Text("${exp.amount} - ${exp.category}"),
                  subtitle: Text(exp.note),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => ExpenseForm(expense: exp),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<ExpenseCubit>().deleteExpense(exp.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(child: Text("Ma’lumot yo‘q"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (_) => const ExpenseForm());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
