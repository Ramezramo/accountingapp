import 'package:accounting_app_last/model/ol_fls/category_transaction.dart';
import 'package:accounting_app_last/newdfiles/dboperations/categoryobject.dart';
import 'package:accounting_app_last/newdfiles/dboperations/financialaccount.dart';
import 'package:accounting_app_last/newdfiles/dboperations/transaction_object.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../model/ol_fls/bank_account.dart';
import '../../model/ol_fls/transaction.dart';

class SqlDb {
  static const integerPrimaryKeyAutoincrement =
      'INTEGER PRIMARY KEY AUTOINCREMENT';
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
  CREATE TABLE IF NOT EXISTS "totals"(
    "id" $integerPrimaryKeyAutoincrement,
    "income" $integerNotNull,
    "expenses" $integerNotNull,
    "totalTransactions" $integerNotNull,
    "totalCatecories" $integerNotNull,
    "totalFinancialAccounts" $integerNotNull
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

    ///set the totals by 0 for the first time and then it will just updated

    // SqlDb.instance.insertData();
    await db.rawInsert("""
  INSERT INTO totals (
                        "income","expenses","totalTransactions","totalCatecories","totalFinancialAccounts"
                        ) VALUES (
                        '0','0','0','0','0'
                                  );
""");
  }

  Future<List<CategoryTransaction>> selectAll() async {
    final db = await database;

    final orderByASC = '${CategoryTransactionFields.createdAt} ASC';

    final result =
        await db!.query(categoryTransactionTable, orderBy: orderByASC);
    var listedResult =
        result.map((json) => CategoryTransaction.fromJson(json)).toList();
    

    return listedResult;
  }

  Future<CategoryTransactionRM> selectById(int id) async {
    final db = await database;

    final maps = await db!.query(
      categoryTransactionTableRM,
      columns: CategoryTransactionFieldsRM.allFields,
      where: '${CategoryTransactionFieldsRM.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return CategoryTransactionRM.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }
  Future<List<TransactionRM>> fetchTransactions() async {
    // Fetch the data from the 'transactions' table using readTableData
    List<Map> maps = await readTableData(transactionTableRM);

    // Convert the List<Map> to List<TransactionRM>
    print(maps);
    var resultIs = maps.map((transaction) {
      return TransactionRM.fromJson(transaction.cast<String, Object?>());
    }).toList();
    print(resultIs);
    return resultIs;
  }
  Future<int> updateItem(TransactionRM item) async {
    final db = await database;

    // You can use `rawUpdate` to write the query in SQL
    return db!.update(
      transactionTable,
      item.toJson(update: true),
      where: '${TransactionFields.id} = ?',
      whereArgs: [item.id],
    );
  }
  Future<List<Map<String, Object?>>?> accountDailyBalance(
    int accountId, {
    DateTime? dateRangeStart,
    DateTime? dateRangeEnd,
  }) async {
    final db = await database;

    final accountFilter =
        "(${TransactionFieldsRM.idBankAccount} = $accountId OR ${TransactionFieldsRM.idBankAccountTransfer} = $accountId)";
    final recurrentFilter = "(${TransactionFields.recurring} = 0)";
    final periodFilterEnd = dateRangeEnd != null
        ? "strftime('%Y-%m-%d', ${TransactionFieldsRM.date}) < '${dateRangeEnd.toString().substring(0, 10)}'"
        : "";
    final filters = [periodFilterEnd, accountFilter, recurrentFilter];
    final sqlFilters = filters.where((filter) => filter != "").join(" AND ");

    final resultQuery = await db?.rawQuery('''
      SELECT
        strftime('%Y-%m-%d', ${TransactionFieldsRM.date}) as day,
        SUM(CASE WHEN (${TransactionFieldsRM.type} = 'IN' OR (${TransactionFieldsRM.type} = 'TRSF' AND ${TransactionFieldsRM.idBankAccountTransfer} = $accountId)) THEN ${TransactionFieldsRM.amount} ELSE 0 END) as income,
        SUM(CASE WHEN ${TransactionFieldsRM.type} = 'OUT' OR (${TransactionFieldsRM.type} = 'TRSF' AND ${TransactionFieldsRM.idBankAccount} = $accountId) THEN ${TransactionFieldsRM.amount} ELSE 0 END) as expense
      FROM "$transactionTableRM"
      WHERE $sqlFilters
      GROUP BY day
    ''');

    final statritngValue = await db?.rawQuery('''
      SELECT ${BankAccountFieldsRM.startingValue} as Value
      FROM $bankAccountTableRM
      WHERE ${BankAccountFieldsRM.id} = $accountId
    ''');

    double runningTotal = statritngValue![0]['Value'] as double;

    var result = resultQuery?.map((e) {
      runningTotal += double.parse(e['income'].toString()) -
          double.parse(e['expense'].toString());
      return {"day": e["day"], "balance": runningTotal};
    }).toList();

    if (dateRangeStart != null) {
      return result
          ?.where((element) => dateRangeStart.isBefore(
              DateTime.parse(element["day"].toString())
                  .add(const Duration(days: 1))))
          .toList();
    }

    return result;
  }

  Future<BankAccountRM> insertBankAccount(
      BankAccountRM item, bool printTableData) async {
    final db = await database;

    // await changeMainAccount(db, item);

    final id = await db!.insert(bankAccountTableRM, item.toJson());
    if (printTableData) {
      print(await readTableData(bankAccountTableRM));
    }

    return item.copy(id: id);
  }

  Future<List<BankAccountRM>?> selectAllAccounts() async {
    final db = await database;

    final orderByASC = '${BankAccountFieldsRM.createdAt} ASC';
    final where =
        '${BankAccountFieldsRM.active} = 1 AND (${TransactionFieldsRM.recurring} = 0 OR ${TransactionFieldsRM.recurring} is NULL)';

    final result = await db?.rawQuery('''
      SELECT b.*, (b.${BankAccountFieldsRM.startingValue} +
      SUM(CASE WHEN t.${TransactionFieldsRM.type} = 'IN' OR t.${TransactionFieldsRM.type} = 'TRSF' AND t.${TransactionFieldsRM.idBankAccountTransfer} = b.${TransactionFieldsRM.id} THEN t.${TransactionFieldsRM.amount}
               ELSE 0 END) -
      SUM(CASE WHEN t.${TransactionFieldsRM.type} = 'OUT' OR t.${TransactionFieldsRM.type} = 'TRSF' AND t.${TransactionFieldsRM.idBankAccount} = b.${TransactionFieldsRM.id} THEN t.${TransactionFieldsRM.amount}
               ELSE 0 END)
    ) as ${BankAccountFieldsRM.total}
      FROM $bankAccountTableRM as b
      LEFT JOIN "$transactionTableRM" as t ON t.${TransactionFieldsRM.idBankAccount} = b.${BankAccountFieldsRM.id} OR t.${TransactionFieldsRM.idBankAccountTransfer} = b.${BankAccountFieldsRM.id}
      WHERE $where
      GROUP BY b.${BankAccountFieldsRM.id}
      ORDER BY $orderByASC
    ''');

    List<BankAccountRM> resultQuery =
        result!.map((json) => BankAccountRM.fromJson(json)).toList();
    print(resultQuery);
    return resultQuery;
  }

  Future<List<CategoryTransactionRM>> selectAllCategories() async {
    final db = await database;

    final orderByASC = '${CategoryTransactionFieldsRM.createdAt} ASC';

    final result =
        await db?.query(categoryTransactionTableRM, orderBy: orderByASC);
    var listedResult =
        result!.map((json) => CategoryTransactionRM.fromJson(json)).toList();
    print(listedResult);

    return listedResult;
  }

  Future<CategoryTransactionRM> insertCategoryDB(
      CategoryTransactionRM item, bool printTableData) async {
    final db = await database;
    final id = await db?.insert(categoryTransactionTableRM, item.toJson());
    // stoped in here this prints the objects
    if (printTableData) {
      print(await readTableData(transactionTableRM));
    }
    return item.copy(id: id);
  }

  Future<TransactionRM> insertTransactionRM(TransactionRM item) async {
    final db = await database;
    final id = await db?.insert(transactionTableRM, item.toJson());
    print(item.toJson());
    print(id);
    await updateTotals();
    readTableData(transactionTableRM);
    return item.copy(id: id);
  }

  Future updateTotals() async {
    /// this function will be executed every time the user makes an operation
    double income = 0;
    double expenses = 0;
    int totalTransactions = 0;
    int totalCatecories = 0;
    int totalFinancialAccounts = 0;
    Database? mydb = _database;
    print("updateTotals1");
    List<Map> transactions =
        await mydb!.rawQuery("SELECT * FROM '$transactionTableRM'");
    List<Map> categories =
        await mydb.rawQuery("SELECT * FROM '$categoryTransactionTableRM'");
    List<Map> financialAccounts =
        await mydb.rawQuery("SELECT * FROM '$bankAccountTableRM'");

    print("updateTotals2");
    // print(response);
    totalTransactions = transactions.length;
    totalCatecories = categories.length;
    totalFinancialAccounts = financialAccounts.length;
    print("updateTotals3");
    for (Map transaction in transactions) {
      if (transaction[TransactionFieldsRM.type] ==
          TransactionFieldsRM.typeIncome) {
        income += transaction[TransactionFieldsRM.amount];
      } else if (transaction[TransactionFieldsRM.type] ==
          TransactionFieldsRM.typeExpenses) {
        expenses += transaction[TransactionFieldsRM.amount];
      }
    }
    print("updateTotals4");
//  "income","expenses","totalTransactions","totalCatecories","totalFinancialAccounts"
    //   int totalTransactions = 0;
    // int totalCatecories = 0;
    // int totalFinancialAccounts = 0;

    await SqlDb.instance
        .updateData("UPDATE 'totals' SET 'income' = '$income' WHERE id = 1");
    await SqlDb.instance.updateData(
        "UPDATE 'totals' SET 'expenses' = '$expenses' WHERE id = 1");
    print("updateTotals5");
    await SqlDb.instance.updateData(
        "UPDATE 'totals' SET 'totalTransactions' = '$totalTransactions' WHERE id = 1");
    await SqlDb.instance.updateData(
        "UPDATE 'totals' SET 'totalCatecories' = '$totalCatecories' WHERE id = 1");
    await SqlDb.instance.updateData(
        "UPDATE 'totals' SET 'totalFinancialAccounts' = '$totalFinancialAccounts' WHERE id = 1");
    // print(upinc);
    // print(upexp);
    // return response;
  }

  Future<List<Map>> readTableData(String tableNameb) async {
    // await SqlDb.instance.updateTotals();
    Database? mydb = _database;
    print(tableNameb);
    List<Map> response = await mydb!.rawQuery("SELECT * FROM '$tableNameb'");
    print(response);

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
    print(sql);
    Database? mydb = _database;
    int response = await mydb!.rawInsert(sql);
    await updateTotals();
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
    Future<int> deleteVal = mydb!.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return deleteVal;
  }

  Future<void> deleteTable(tableName) async {
    // Get a reference to the database.
    Database? mydb = _database;

    // Delete all rows from the specified table without any condition
    await mydb?.delete(tableName);
  }

  Future clearDatabase() async {
    try {
      await _database?.transaction((txn) async {
        var batch = txn.batch();
        batch.delete(transactionTableRM);
        batch.delete(categoryTransactionTableRM);
        batch.delete(bankAccountTableRM);
        batch.delete(bankAccountTableRM);
        await batch.commit();
      });
    } catch (error) {
      throw Exception('DbBase.cleanDatabase: $error');
    }
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
