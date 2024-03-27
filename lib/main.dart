import 'package:accountingapp/views/homepage/homepagemain.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

import 'db/DealWithDataBase.dart';
import 'db/addingnewuserobject.dart';
import 'db/appsettingsobject.dart';

Future<void> checkDataBaseForTheFirstTime () async {
  ///will checkout the database and find-out if the first time open it will insert these settings
  final DatabaseHelper dbHelper = DatabaseHelper();

  // Initialize settings table
  await dbHelper.initializeDatabase();

  List<Map<String, dynamic>>? themeValue = await dbHelper.getSettingValueByKey("delete-main-file");
  print(themeValue);


  // Retrieve all settings
  List<Settings> allSettings = await dbHelper.getAllSettings();

  allSettings.forEach((element) {
    print(element);
  });

  var ramez = User(id: 00, name: 'ramez', age: 22);
  await dbHelper.insertUser(ramez);
  print(await dbHelper.users());

}
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  checkDataBaseForTheFirstTime();

  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    // initConnectycube();
  }

  // initConnectycube() {
  //   init(
  //     config.APP_ID,
  //     config.AUTH_KEY,
  //     config.AUTH_SECRET,
  //     onSessionRestore: () {
  //       return SharedPrefs.getUser().then((savedUser) {
  //         return createSession(savedUser);
  //       });
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Your App Title'),
        // ),
        body: Builder(builder: (context) {
          // CallManager.instance.init(context);

          // Here you can place the content of your app
          return HomePage();
        }),
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        timePickerTheme: TimePickerThemeData(
          dayPeriodTextColor: Colors.cyanAccent.shade700,
          //hourMinuteColor: Colors.cyanAccent.shade700,

        ),
        hintColor: Colors.cyanAccent.shade700,
        primaryColor: Colors.cyanAccent,
        primaryColorDark: Colors.grey.shade700,
        primaryColorLight: Colors.grey.shade200,
        //highlightColor: Colors.amber.shade700,

      ),
      localizationsDelegates: const [
        // ... app-specific localization delegate[s] here
        // GlobalMaterialLocalizations.delegate,
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        // English, no country code
        Locale('he', ''),
        // Hebrew, no country code
        Locale('ar', ''),
        // Hebrew, no country code
        Locale.fromSubtags(languageCode: 'zh'),
        // Chinese *See Advanced Locales below*
        // ... other locales the app supports
      ],
    );
  }
}