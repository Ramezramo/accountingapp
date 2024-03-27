import 'package:accountingapp/views/homepage/homepagemain.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

import 'db/addingnewuser.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Future <Database> database = openDatabase(join(await getDatabasesPath(),'gg_database.db'),onCreate: (db,version){
    return db.execute("CREATE TABLE users(id INTEGER PRIMARY KEY,name TEXT, age INTEGER)");
  },version: 1);
  Future<void> insertUser(User user)async {
    final Database db = await database ;
    await db.insert("users", user.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future <List<User>> users()async{
    final Database db = await database;
    final List <Map<String,dynamic>> maps = await db.query("users");
    return List.generate(maps.length, (index) => User(id: maps[index]['id'], name: maps[index]['name'], age: maps[index]['age']));

  }

  Future<void> updateUser(User user)async {
    final Database db = await database ;
    await db.update('users', user.toMap(),
    where: "id = ?",
      whereArgs: [user.id]
    );

  }

  var ramez = User(id: 00, name: 'ramez', age: 22);
  await insertUser(ramez);
  print(await users());

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