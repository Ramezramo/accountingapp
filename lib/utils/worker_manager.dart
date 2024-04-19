import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:workmanager/workmanager.dart";

import "../pages/notifications/notifications_service.dart";
import "../providers/settings_provider.dart";

//tasks
const taskShowNotification = "showReminder";

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case taskShowNotification:
        await notificationsPlugin.show(
            0,
            "Remember to log new expenses!",
            "accounting_app_last is waiting for your latest transactions. Don't lose sight of your financial movements, and input your most recent expenses.",
            const NotificationDetails(
              android: AndroidNotificationDetails(
                  'accounting_app_last#reminder', 'reminder',
                  importance: Importance.max, priority: Priority.max),
              iOS: DarwinNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
              ),
            ));
    }
    return Future.value(true);
  });
}

void toggleTransactionReminder(bool toActive) async {
  if (!toActive) {
    await Workmanager().cancelByUniqueName("accounting_app_last#reminder");
  }
}

void scheduleTransactionReminder(NotificationReminderType type) async {
  await Workmanager().cancelByUniqueName("accounting_app_last#reminder");
  await Workmanager().registerPeriodicTask(
      "accounting_app_last#reminder", taskShowNotification,
      frequency: Duration(
          days: type == NotificationReminderType.daily
              ? 1
              : type == NotificationReminderType.weekly
                  ? 7
                  : 30));
}

void scheduleAlertRecursiveTransaction() {
  //TODO
  Workmanager()
      .cancelByUniqueName("accounting_app_last#alert")
      .then((value) => {
            Workmanager().registerPeriodicTask(
                "accounting_app_last#alert", taskShowNotification,
                frequency: const Duration(days: 30))
          });
}
