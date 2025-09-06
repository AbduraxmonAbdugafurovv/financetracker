import 'dart:io';

import 'package:financetreckerapp/features/auth/presentation/pages/sign_in.dart';
import 'package:financetreckerapp/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:financetreckerapp/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:financetreckerapp/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<ProfileCubit>().getUser();
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
                  
                  // ElevatedButton(onPressed: (){}, child: Text("")),
                  IconButton(
                    onPressed: ()  {
                      
                      
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
          return Center(child: CircularProgressIndicator.adaptive());
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

 final plugin = FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  const initSettings = InitializationSettings(android: androidInit);

  await plugin.initialize(initSettings);
}

Future<void> showDailyReminder() async {
  await plugin.periodicallyShow(
    androidScheduleMode: AndroidScheduleMode.alarmClock,
    0,
    'Eslatma',
    'Bugungi xarajatlaringizni yozishni unutmang 💰',
    RepeatInterval.daily, // har kuni qaytaradi
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel',
        'Daily Reminder',
        channelDescription: 'Har kuni eslatma uchun kanal',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
  
  );
}

}
