import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sossoldi/database/DealWithDataBase.dart';
import 'package:sossoldi/database/addingnewuserobject.dart';
import 'package:sossoldi/database/appsettingsobject.dart';
import 'package:workmanager/workmanager.dart';
import 'package:sossoldi/utils/worker_manager.dart';
import 'pages/notifications/notifications_service.dart';
import 'providers/theme_provider.dart';
import 'routes.dart';
import 'utils/app_theme.dart';

Future<void> checkDataBaseForTheFirstTime () async {
  ///will checkout the database and find-out if the first time open it will insert these settings
  final DatabaseHelper dbHelper = DatabaseHelper();

  // Initialize settings table
  await dbHelper.initializeDatabase();

  List<Map<String, dynamic>>? themeValue = await dbHelper.getSettingValueByKey("delete-main-file");
  print(themeValue);


  // Retrieve all settings
  List<Settings> allSettings = await dbHelper.getAllSettings();

  for (var element in allSettings) {
    print(element);
  }

  var ramez = User(id: 00, name: 'ramez', age: 22);
  await dbHelper.insertUser(ramez);
  print(await dbHelper.logAllUsers());

}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isAndroid){
    checkDataBaseForTheFirstTime();
    requestNotificationPermissions();
    initializeNotifications();
    Workmanager().initialize(callbackDispatcher);


  }
  initializeDateFormatting('it_IT', null).then((_) => runApp(const ProviderScope(child: Launcher())));
}

class Launcher extends ConsumerWidget {
  const Launcher({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    return MaterialApp(
      title: 'AppName',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          appThemeState.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      onGenerateRoute: makeRoute,
      initialRoute: '/',
    );
  }
}
