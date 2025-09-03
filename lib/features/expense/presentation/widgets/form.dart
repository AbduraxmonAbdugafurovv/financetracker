// import 'package:financetreckerapp/features/expense/domain/expense.dart';
// import 'package:financetreckerapp/features/expense/presentation/cubit/expence_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ExpenseForm extends StatefulWidget {
//   final Expense? expense;
//   const ExpenseForm({super.key, this.expense});

//   @override
//   State<ExpenseForm> createState() => _ExpenseFormState();
// }

// class _ExpenseFormState extends State<ExpenseForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _amountController = TextEditingController();
//   final _noteController = TextEditingController();
//   String _selectedCategory = "Oziq-ovqat";

//   @override
//   void initState() {
//     super.initState();
//     if (widget.expense != null) {
//       _amountController.text = widget.expense!.amount.toString();
//       _noteController.text = widget.expense!.note;
//       _selectedCategory = widget.expense!.category;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(widget.expense == null ? "Yangi xarajat" : "Xarajatni tahrirlash"),
//       content: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextFormField(
//               controller: _amountController,
//               decoration: const InputDecoration(labelText: "Summasi"),
//               keyboardType: TextInputType.number,
//             ),
//             DropdownButtonFormField(
//               value: _selectedCategory,
//               items: ["Oziq-ovqat", "Transport", "Ko'ngilochar", "Kommunal", "Boshqa"]
//                   .map((c) => DropdownMenuItem(value: c, child: Text(c)))
//                   .toList(),
//               onChanged: (val) => setState(() => _selectedCategory = val!),
//             ),
//             TextFormField(
//               controller: _noteController,
//               decoration: const InputDecoration(labelText: "Izoh"),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text("Bekor qilish"),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             final expense = Expense(
//               id: widget.expense?.id ?? DateTime.now().toString(),
//               amount: double.parse(_amountController.text),
//               category: _selectedCategory,
//               date: DateTime.now(),
//               note: _noteController.text,
//             );
//             if (widget.expense == null) {
//               context.read<ExpenseCubit>().addExpense(expense);
//             } else {
//               context.read<ExpenseCubit>().updateExpense(expense);
//             }
//             Navigator.pop(context);
//           },
//           child: const Text("Saqlash"),
//         ),
//       ],
//     );
//   }
// }
