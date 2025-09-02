import 'package:financetreckerapp/features/auth/presentation/cubit/cubit.dart';
import 'package:financetreckerapp/features/auth/presentation/pages/sign_in.dart';
import 'package:financetreckerapp/features/expense/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:financetreckerapp/features/auth/presentation/cubit/state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
              if (state is AuthAuthenticated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Xush kelibsiz, ${state.user.email}")),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                // 🔹 Bu joyda Home page ga navigate qilish mumkin
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  /// EMAIL
                  TextFormField(
                    controller: _emailCtrl,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email kiriting";
                      }
                      if (!value.contains("@")) {
                        return "Email noto‘g‘ri formatda";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  /// PASSWORD
                  TextFormField(
                    controller: _passwordCtrl,

                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.visibility),
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                    // obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Parol kiriting";
                      }
                      if (value.length < 6) {
                        return "Parol kamida 6 ta belgidan iborat bo‘lishi kerak";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  /// SIGN IN BUTTON
                  if (state is AuthLoading)
                    const CircularProgressIndicator()
                  else
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().signUp(
                            _emailCtrl.text.trim(),
                            _passwordCtrl.text.trim(),
                          );
                        }
                      },
                      child: const Text("Sign Up"),
                    ),
                  const SizedBox(height: 20),

                  /// Sign in BUTTON
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInPage()),
                      );
                    },
                    child: const Text("Kirish"),
                  ),

                  const Spacer(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
