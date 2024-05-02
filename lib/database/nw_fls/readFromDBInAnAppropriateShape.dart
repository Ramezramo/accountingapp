import 'package:accounting_app_last/database/nw_fls/DealWithDataBase.dart';
import 'package:accounting_app_last/database/nw_fls/financialaccount.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

Future<List<Map<String, dynamic>>?> getSettingValueByKey(String key) async {
  print("gogogogogog");
  final Database? db = await SqlDb.instance.database;
  List<Map<String, dynamic>> settings = await db!.query(
    'Categorey',
    where: "id = ?",
    whereArgs: [key],
  );
  if (settings.isNotEmpty) {
    print(settings);
    return settings; // Return list of settings matching the key
  } else {
    return null; // Setting not found
  }
}



// Future<void> printCategoryById(Object categoryId) async {
//   print("Get a reference to the database.");
//   final Database? db = await DatabaseHelper.instance.database;

//   // Query the table for the category with the desired ID.
//   final List<Map<String, Object?>>? maps = await db?.query(
//     "Category",
//     where: 'id = ?',
//     whereArgs: [categoryId],
//   );

//   // If a category with the desired ID is found, print its details.
//   if (maps != null && maps.isNotEmpty) {
//     final Map<String, Object?> map = maps.first;
//     print('Category ID: ${map['id']}');
//     print('Category Name: ${map['category_name']}');
//     print('Category Icon: ${map['category_icon']}');
//     print('Color: ${map['color']}');
//   } else {
//     // If no category with the desired ID is found, print a message.
//     print('No category found with ID: $categoryId');
//   }
// }
