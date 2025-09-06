import 'package:financetreckerapp/features/notifications/domain/notification_repository.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;


class NotificationRepositoryImpl implements NotificationRepository {
  final FlutterLocalNotificationsPlugin plugin;

  NotificationRepositoryImpl(this.plugin) {
    tzData.initializeTimeZones();
  }

  @override
  Future<void> scheduleDailyAt20() async {
    final now = tz.TZDateTime.now(tz.local);

    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      05, // 20:00
      22,
    );

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    await plugin.zonedSchedule(
      0,
      "Eslatma",
      "Bugun xarajat yozishni unutmang 💰",
      scheduled,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_channel',
          'Kunlik eslatmalar',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      
    );
  }
}
