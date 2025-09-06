import 'package:financetreckerapp/features/auth/presentation/cubit/cubit.dart';
import 'package:financetreckerapp/features/auth/presentation/pages/reset.dart';
import 'package:financetreckerapp/features/auth/presentation/pages/sign_up.dart';
import 'package:financetreckerapp/features/expense/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:financetreckerapp/features/auth/presentation/cubit/state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Sign In")),
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
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(content: Text("Xush kelibsiz, ${state.user.email}")),
                // );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }
            },
            builder: (context, state) {
              // final visibility = context.watch<AuthCubit>().visiblity;
              if (state is AuthInitial) {
                return Column(
                  children: [
                    SizedBox(height: 35),

                    Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),

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
                      obscureText: context.watch<AuthCubit>().visiblity,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            context.read<AuthCubit>().visibly();
                          },
                          icon: Icon(
                            context.watch<AuthCubit>().visiblity
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        labelText: "Password",
                        border: const OutlineInputBorder(),
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
                            context.read<AuthCubit>().signIn(
                              _emailCtrl.text.trim(),
                              _passwordCtrl.text.trim(),
                            );
                          }
                        },
                        child: const Text("Sign In"),
                      ),
                    const SizedBox(height: 20),

                    /// REGISTER BUTTON
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      child: const Text("Ro‘yxatdan o‘tish"),
                    ),

                    const Spacer(),

                    /// FORGOT PASSWORD TEXT
                    GestureDetector(
                      child: const Text(
                        "Kodini esdan chiqardingmi?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 30),
                  ],
                );
              }
              return Center(child: CircularProgressIndicator.adaptive(),);
            },
          ),
        ),
      ),
    );
  }
}
