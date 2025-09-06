import 'package:financetreckerapp/features/auth/data/auth_data_source.dart';
import 'package:financetreckerapp/features/auth/presentation/cubit/cubit.dart';
import 'package:financetreckerapp/features/auth/presentation/pages/sign_in.dart';
import 'package:financetreckerapp/features/expense/data/expense_data_source.dart';
import 'package:financetreckerapp/features/expense/data/expense_model.dart';
import 'package:financetreckerapp/features/expense/presentation/cubit/expence_cubit.dart';
import 'package:financetreckerapp/features/notifications/data/notification_repositoryiml.dart';
import 'package:financetreckerapp/features/notifications/domain/notification_repository.dart';
import 'package:financetreckerapp/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:financetreckerapp/features/profile/data/profile_remotedata.dart';
import 'package:financetreckerapp/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:financetreckerapp/features/statistics/data/statistic_remote_data.dart';
import 'package:financetreckerapp/features/statistics/presentation/cubit/statistic_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();

  await Hive.openBox<ExpenseModel>('expensesBox');

  Hive.registerAdapter(ExpenseModelAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              AuthCubit(AuthRepository(fb.FirebaseAuth.instance))..checkAuth(),
        ),
        BlocProvider(
          create: (_) =>
              ExpenseCubit(ExpenseRemoteDataSource())..loadExpenses(),
        ),
        BlocProvider(
          create: (_) =>
              StatisticCubit(StatisticRemoteDataSource())
                ..loadLast30DaysExpenses(),
        ),
        BlocProvider(
          create: (_) =>
              ProfileCubit(ProfileRemotedata(fb.FirebaseAuth.instance))
               
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SignInPage(),
      ),
    );
  }
}
