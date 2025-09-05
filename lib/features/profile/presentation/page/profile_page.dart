import 'package:financetreckerapp/features/auth/presentation/pages/sign_in.dart';
import 'package:financetreckerapp/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:financetreckerapp/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    // context.read<ProfileCubit>().getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (state is ProfileLoadedState) {
            final user = state.user;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: 70),
                  Row(),
                  CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.person_2_outlined, size: 33),
                  ),
                  SizedBox(height: 20),
                  Text(user.email),
                  SizedBox(height: 20),
                  IconButton(
                    onPressed: () {
                      context.read<ProfileCubit>().signOut();
                    },
                    icon: Icon(Icons.logout_outlined),
                  ),
                ],
              ),
            );
          } else if (state is ProfileErrorState) {
            return Center(child: Text("Xato: ${state.message}"));
          }
          return Center(child: Text("ERRROROROR"));
        },
        listener: (_, state) {
          if (state is ProfileLogOutState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignInPage()),
            );
          }
        },
      ),
    );
  }
}
