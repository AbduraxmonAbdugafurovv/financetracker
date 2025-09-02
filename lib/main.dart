import 'package:financetreckerapp/features/auth/data/auth_data_source.dart';
import 'package:financetreckerapp/features/auth/presentation/cubit/cubit.dart';
import 'package:financetreckerapp/features/auth/presentation/pages/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(AuthRepository(fb.FirebaseAuth.instance)),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SignInPage(),
      ),
    );
  }
}
