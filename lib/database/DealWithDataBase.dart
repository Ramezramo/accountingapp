import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'addingnewuserobject.dart';
import 'appsettingsobject.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'settings.db');
    print(path);

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("""
  CREATE TABLE IF NOT EXISTS users(
    id INTEGER PRIMARY KEY,
    name TEXT,
    age INTEGER
  );
""");
        await db.execute("""
  CREATE TABLE IF NOT EXISTS settings (
    id INTEGER PRIMARY KEY,
    key TEXT,
    value TEXT
  );
""");

        // Insert default setting
        await db.insert(
          'settings',
          {'id': 1, 'key': 'delete-main-file', 'value': 'false'},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        await db.insert(
          'settings',
          {'id': 2, 'key': 'picture-Width', 'value': '1920'},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        await db.insert(
          'settings',
          {'id': 3, 'key': 'picture-Height', 'value': '1080'},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        await db.insert(
          'settings',
          {'id': 4, 'key': 'pic-quality-after-comp', 'value': '480p'},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        await db.insert(
          'settings',
          {'id': 5, 'key': 'vid-quality-after-comp', 'value': '720p'},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      },
    );

    return database;
  }

  Future<List<Map<String, dynamic>>?> getSettingValueByKey(String key) async {
    final db = await database;
    List<Map<String, dynamic>> settings = await db!.query(
      'settings',
      where: "key = ?",
      whereArgs: [key],
    );
    if (settings.isNotEmpty) {
      return settings; // Return list of settings matching the key
    } else {
      return null; // Setting not found
    }
  }

  Future<void> updateSetting(Settings setting) async {
    final db = await database;
    await db?.update(
      'settings',
      setting.toMap(),
      where: "id = ?",
      whereArgs: [setting.id],
    );
  }

  Future<void> insertSetting(Settings setting) async {
    final Database? db = await database;
    await db?.insert(
      'settings',
      setting.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Settings>> getAllSettings() async {
    final Database? db = await database;
    final List<Map<String, Object?>>? maps = await db?.query('settings');
    return List.generate(maps!.length, (i) {
      return Settings.fromMap(maps[i]);
    });
  }

  Future<void> insertUser(User user) async {
    final Database? db = await database;
    await db?.insert("users", user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> reviewDatabaseTables() async {
    final Database? db = await database;
    if (db != null) {
      List<Map<String, dynamic>> tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table';",
      );
      for (var table in tables) {
        print("Table Name: ${table['name']}");
        // Optionally, you can query each table for its schema
        // and print more details about the table structure.
      }
    }
  }

  Future<List<User>> logAllUsers() async {
    final Database? db = await database;
    final List<Map<String, dynamic>> maps = await db!.query("users");
    return List.generate(
        maps.length,
        (index) => User(
            id: maps[index]['id'],
            name: maps[index]['name'],
            age: maps[index]['age']));
  }

  Future<List<Map<String, dynamic>>> logAllSettingsStoredInDB() async {
    final Database? db = await database;
    final List<Map<String, dynamic>> maps = await db!.query("Settings");
    print(maps);
    return maps;
  }

  Future<void> updateUser(User user) async {
    final Database? db = await database;
    await db
        ?.update('users', user.toMap(), where: "id = ?", whereArgs: [user.id]);
  }

  dynamic returnValueKey(List<Map<String, dynamic>>? key, String targetKey) {
    /// here you will send the object and it will return the value of the key like this
    /// Settings{id: 4, key: pic-quality-after-comp, value: 480p}
    /// it will return the if you targetting the key "value" it will return "480p"
    ///List<Map<String, dynamic>>? delete_main_file = await dbHelper.getSettingValueByKey("delete-main-file");
    ///print(returnValueKey(delete_main_file,"value"));
    if (key == null) return null;

    // Iterate through the list of maps
    for (var map in key) {
      // Check if the map contains the target key
      if (map.containsKey(targetKey)) {
        // Return the value associated with the target key
        return map[targetKey];
      }
    }

    // If the target key is not found, return null or handle it as needed
    return null;
  }

  bool updateSettingsValueKey(String keyName, String newValue) {
    /// here you will update the object value like this
    /// Settings{id: 4, key: pic-quality-after-comp, value: 480p}
    /// it will update it to the new value lets suppose the newValue var is 720p the update in date base will be like this
    /// Settings{id: 4, key: pic-quality-after-comp, value: 720p}
    try {
      Settings updatedSetting = Settings(id: 1, key: keyName, value: newValue);
      updateSetting(updatedSetting);
      return true; // Return true if the update operation succeeds
    } catch (e) {
      // Catch any exception and return false indicating the update operation failed

      print('Failed to update setting: $e');
      // Print the error for debugging
      return false;
    }
  }
}

// class DataBaseDealer {
//   late final Future<Database> database;
//
//   Future<void> prepareDataBase() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     print("preparing data base");
//
//     database = openDatabase(
//       join(await getDatabasesPath(), 'gg_database.db'),
//       onCreate: (db, version) {
//         return db.execute("CREATE TABLE on-off-settings(id INTEGER PRIMARY KEY,setting-name TEXT, statue INTEGER)");
//       },
//       version: 1,
//     );
//   }
//
//   Future<void> insertUser(User user) async {
//     // await prepareDataBase();
//     final Database db = await database;
//     await db.insert("users", user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
//   }
//
//   Future<List<User>> users() async {
//     // await prepareDataBase();
//     final Database db = await database;
//     final List<Map<String, dynamic>> maps = await db.query("users");
//     return List.generate(maps.length, (index) => User(id: maps[index]['id'], name: maps[index]['name'], age: maps[index]['age']));
//   }
//
//   Future<void> updateUser(User user) async {
//     // await prepareDataBase();
//     final Database db = await database;
//     await db.update(
//       'users',
//       user.toMap(),
//       where: "id = ?",
//       whereArgs: [user.id],
//     );
//   }
//
//   Future<void> tester() async {
//     // await prepareDataBase();
//     var ramez = User(id: 50, name: 'ramez', age: 22);
//     await insertUser(ramez);
//     print(await users());
//   }
// }
