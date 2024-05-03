import 'package:accounting_app_last/database/nw_fls/categoryobject.dart';
import 'package:accounting_app_last/database/nw_fls/financialaccount.dart';
import 'package:accounting_app_last/database/nw_fls/transaction_object.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../model/ol_fls/transaction.dart';

class SqlDb {
    static const integerPrimaryKeyAutoincrement = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    static const integerNotNull = 'INTEGER NOT NULL';
    static const integer = 'INTEGER';
    static const realNotNull = 'REAL NOT NULL';
    static const textNotNull = 'TEXT NOT NULL';
    static const text = 'TEXT';
  SqlDb._privateConstructor();
  static final SqlDb instance = SqlDb._privateConstructor();

  // Only have a single app-wide reference to the database.
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    // Lazily instantiate the db the first time it is accessed.
    _database = await _initDatabase();
    return _database;
  }

  String dbName = 'myowndb.db';
  _initDatabase() async {
    final path = join(await getDatabasesPath(), dbName);

    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 3, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("onUpgrade =====================================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE "notes" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "note" TEXT NOT NULL
  )
 ''');

    await db.execute("""
  CREATE TABLE IF NOT EXISTS "users"(
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
    "name" TEXT,
    "age" INTEGER
  );
""");

    await db.execute('''
      CREATE TABLE `$bankAccountTableRM`(
        `${BankAccountFieldsRM.id}` $integerPrimaryKeyAutoincrement,
        `${BankAccountFieldsRM.name}` $textNotNull,
        `${BankAccountFieldsRM.symbol}` $textNotNull,
        `${BankAccountFieldsRM.color}` $integerNotNull,
        `${BankAccountFieldsRM.startingValue}` $realNotNull,
        `${BankAccountFieldsRM.active}` $integerNotNull CHECK (${BankAccountFieldsRM.active} IN (0, 1)),
        `${BankAccountFieldsRM.mainAccount}` $integerNotNull CHECK (${BankAccountFieldsRM.mainAccount} IN (0, 1)),
        `${BankAccountFieldsRM.createdAt}` $textNotNull,
        `${BankAccountFieldsRM.updatedAt}` $textNotNull
      )
      ''');
    await db.execute('''
      CREATE TABLE `$categoryTransactionTableRM`(
        `${CategoryTransactionFieldsRM.id}` $integerPrimaryKeyAutoincrement,
        `${CategoryTransactionFieldsRM.name}` $textNotNull,
        `${CategoryTransactionFieldsRM.symbol}` $textNotNull,
        `${CategoryTransactionFieldsRM.color}` $integerNotNull,
        `${CategoryTransactionFieldsRM.note}` $text,
        `${CategoryTransactionFieldsRM.parent}` $integer,
        `${CategoryTransactionFieldsRM.createdAt}` $textNotNull,
        `${CategoryTransactionFieldsRM.updatedAt}` $textNotNull
      )
    ''');
    await db.execute('''
      CREATE TABLE `$transactionTableRM`(
        `${TransactionFieldsRM.id}` $integerPrimaryKeyAutoincrement,
        `${TransactionFieldsRM.date}` $text,
        `${TransactionFieldsRM.amount}` $realNotNull,
        `${TransactionFieldsRM.type}` $integerNotNull,
        `${TransactionFieldsRM.note}` $text,
        `${TransactionFieldsRM.idCategory}` $integer,
        `${TransactionFieldsRM.idBankAccount}` $integerNotNull,
        `${TransactionFieldsRM.idBankAccountTransfer}` $integer,
        `${TransactionFieldsRM.recurring}` $integerNotNull CHECK (${TransactionFieldsRM.recurring} IN (0, 1)),
        `${TransactionFieldsRM.recurrencyType}` $text,
        `${TransactionFieldsRM.recurrencyPayDay}` $integer,
        `${TransactionFieldsRM.recurrencyFrom}` $text,
        `${TransactionFieldsRM.recurrencyTo}` $text,
        `${TransactionFieldsRM.createdAt}` $textNotNull,
        `${TransactionFieldsRM.updatedAt}` $textNotNull
      )
    ''');
  }

  Future<List<Map>> readTableData(String tableNameb)async {
    Database? mydb = _database;
    List<Map> response = await mydb!.rawQuery("SELECT * FROM '$tableNameb'");
    return response;
  }

  Future<Map<String, dynamic>?> getRowById(String tableName, int id) async {
    // Open the database

    // Get a reference to the database.
    Database? mydb = _database;

    // Query the table for the row with the provided ID.
    final List<Map<String, Object?>>? result = await mydb?.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result!.isNotEmpty) {
      // Return the first row found (assuming there's only one row for the given ID)
      print(result.first);
      return result.first;
    } else {
      // If no row found with the provided ID, return null
      return null;
    }
  }

  Future<int> insertData(String sql) async {
    Database? mydb = _database;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  Future<int> updateData(String sql) async {
    Database? mydb = _database;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  Future<Future<int>?> deleteData(int id, String tableName) async {
    /// just pass the id of the row and table name it will be deleted
    Database? mydb = _database;
    return mydb?.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteTable(tableName) async {
    // Get a reference to the database.
    Database? mydb = _database;

    // Delete all rows from the specified table without any condition
    await mydb?.delete(tableName);
  }

  Future<void> deleteDB() async {
    final path = join(await getDatabasesPath(), dbName);
    await deleteDatabase(path);
  }
// SELECT
// DELETE
// UPDATE
// INSERT
}
