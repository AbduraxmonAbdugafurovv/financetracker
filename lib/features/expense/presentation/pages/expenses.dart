import 'package:financetreckerapp/features/expense/domain/expense.dart';
import 'package:financetreckerapp/features/expense/presentation/cubit/expence_cubit.dart';
import 'package:financetreckerapp/features/expense/presentation/cubit/expence_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Xarajatlar boshqaruvi")),
      body: BlocBuilder<ExpenseCubit, ExpenseState>(
        builder: (context, state) {
          if (state is ExpenseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExpenseLoaded) {
            final expenses = state.expenses;
            if (expenses.isEmpty) {
              return const Center(child: Text("Xarajatlar mavjud emas"));
            }
            return ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return ListTile(
                  title: Text("${expense.category} - ${expense.amount} so'm"),
                  subtitle: Text("${expense.date.toLocal()} \n${expense.note}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showExpenseDialog(context, expense: expense);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<ExpenseCubit>().deleteExpense(expense.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is ExpenseError) {
            return Center(child: Text("Xato: ${state.e}"));
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showExpenseDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
void _showExpenseDialog(BuildContext context, {Expense? expense}) {
  final amountController =
      TextEditingController(text: expense?.amount.toString() ?? "");
  final noteController = TextEditingController(text: expense?.note ?? "");
  String category = expense?.category ?? "Oziq-ovqat";

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(expense == null
                ? "Xarajat qo'shish"
                : "Xarajatni tahrirlash"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: amountController,
                  decoration: const InputDecoration(labelText: "Summasi"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: noteController,
                  decoration: const InputDecoration(labelText: "Izoh"),
                ),
                DropdownButton<String>(
                  value: category,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        category = value;
                      });
                    }
                  },
                  items: const [
                    DropdownMenuItem(
                        value: "Oziq-ovqat", child: Text("Oziq-ovqat")),
                    DropdownMenuItem(
                        value: "Transport", child: Text("Transport")),
                    DropdownMenuItem(
                        value: "Ko'ngilochar", child: Text("Ko'ngilochar")),
                    DropdownMenuItem(
                        value: "Kommunal", child: Text("Kommunal")),
                    DropdownMenuItem(value: "Boshqa", child: Text("Boshqa")),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Bekor qilish"),
              ),
              ElevatedButton(
                onPressed: () {
                  final amount =
                      double.tryParse(amountController.text) ?? 0.0;
                  if (expense == null) {
                    // Yangi qo‘shish
                    context.read<ExpenseCubit>().addExpense(
                          Expense(
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            amount: amount,
                            category: category,
                            date: DateTime.now(),
                            note: noteController.text,
                          ),
                        );
                  } else {
                    // Tahrirlash
                    context.read<ExpenseCubit>().updateExpense(
                          Expense(
                            id: expense.id,
                            amount: amount,
                            category: category,
                            date: expense.date,
                            note: noteController.text,
                          ),
                        );
                  }
                  Navigator.pop(context);
                },
                child: const Text("Saqlash"),
              ),
            ],
          );
        },
      );
    },
  );
}
}
