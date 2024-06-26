import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../dboperations/DealWithDataBase.dart';
import '../../../../dboperations/categoryobject.dart';
import '../../../../dboperations/financialaccount.dart';
import '../../../../dboperations/transaction_object.dart';
// import '../../dboperations/DealWithDataBase.dart';
// import '../../dboperations/categoryobject.dart';
// import '../../dboperations/financialaccount.dart';
// import '../../dboperations/transaction_object.dart';

part 'dboperationsbloc_state.dart';

class DboperationsblocCubit extends Cubit<DboperationsblocState> {
  DboperationsblocCubit() : super(AddingTransactionblocLoading()) {
    readExpensesAndIncome();
    readAllTransactions();
  }

  void readExpensesAndIncome() async {
    try {
      emit(AddingTransactionblocLoading());
      final result = await _readExpensesAndIncome();
      final resultrtrt = await SqlDb.instance.fetchTransactions();
      print(resultrtrt);
      emit(AddingTransactionblocSuccess(result[0],resultrtrt));
    } catch (error) {
      emit(AddingTransactionblocFailure(error.toString()));
    }
  }

  Future<List<Map>> _readExpensesAndIncome() async {
    List<Map> readTableRes = await SqlDb.instance.readTableData("totals");
    return readTableRes;
  }

  Future<void> readAllTransactions() async {
    emit(AddingCategoryblocLoading());
    try {
      final result = await SqlDb.instance.fetchTransactions();

      // emit(TransactionFblocSuccess(result));
    } catch (error) {
      print(error);
      emit(AddingCategoryBlocFailure(error.toString()));
    }
  }

  Future<void> insertCategory(CategoryTransactionRM item) async {
    emit(AddingCategoryblocLoading());
    try {
      print(item.toJson());
      final result = await SqlDb.instance.insertCategoryDB(item, true);
      print(result);
      final readDbData = await _readExpensesAndIncome();
      print(readDbData[0]);
      emit(AddingCategoryblocSuccess(readDbData[0]));
    } catch (error) {
      print(error);
      emit(AddingCategoryBlocFailure(error.toString()));
    }
  }
  // Future<void> insertBankAccount(BankAccountRM item) async {
  //   emit(AddingTransactionblocLoading());
  //   try {
  //     print(item.toJson());
  //     final result = await SqlDb.instance.insertBankAccount(item,true);
  //     print(result);
  //     final readDbData = await _readExpensesAndIncome();
  //     var accountsList = await SqlDb.instance.selectAllAccounts();
  //     print(accountsList);
  //     emit(AddingTransactionblocSuccess(accountsList as Map));
  //   } catch (error) {
  //     print(error);
  //     emit(AddingTransactionblocFailure(error.toString()));
  //   }
  // }

  Future<void> insertTransaction(TransactionRM item) async {
    emit(AddingTransactionblocLoading());
    try {
      print("code dfsfsdf");
      print(item.toJson());
      final result = await SqlDb.instance.insertTransactionRM(item);
      print(result);
      final readDbData = await _readExpensesAndIncome();
            final resultrtrt = await SqlDb.instance.fetchTransactions();
      print(resultrtrt);
      print(readDbData[0]);
      emit(AddingTransactionblocSuccess(readDbData[0],resultrtrt));
    } catch (error) {
      print(error);
      emit(AddingTransactionblocFailure(error.toString()));
    }
  }

  // Future<List<Map>> _insertTransaction(
  //     DateTime date, num amount, String type, String note) async {
  //   String insertUsAccTransactionQuery = """
  //   INSERT INTO $transactionTableRM (
  //         ${TransactionFieldsRM.date},
  //         ${TransactionFieldsRM.amount},
  //         ${TransactionFieldsRM.type},
  //         ${TransactionFieldsRM.note},
  //         ${TransactionFieldsRM.idCategory},
  //         ${TransactionFieldsRM.idBankAccount},
  //         ${TransactionFieldsRM.idBankAccountTransfer},
  //         ${TransactionFieldsRM.recurring},
  //         ${TransactionFieldsRM.recurrencyType},
  //         ${TransactionFieldsRM.recurrencyPayDay},
  //         ${TransactionFieldsRM.recurrencyFrom},
  //         ${TransactionFieldsRM.recurrencyTo},
  //         ${TransactionFieldsRM.createdAt},
  //         ${TransactionFieldsRM.updatedAt}
  //   ) VALUES (
  //     '$date', '$amount', '$type', '$note', 'idCategory_value',
  //     'idBankAccount_value', 'idBankAccountTransfer_value', '0',
  //     'recurrencyType_value', 'recurrencyPayDay_value', 'recurrencyFrom_value',
  //     'recurrencyTo_value', 'createdAt_value', 'updatedAt_value'
  //   );
  // """;

  //   print(await SqlDb.instance.insertData(insertUsAccTransactionQuery));

  //   print(readDbData);
  //   return readDbData;
  // }

//   void insertTransaction(date, amount, type, note) async {
//     emit(DboperationsblocLoading());
//     try {
//       await _insertTransaction(date, amount, type, note);
//       final result = await _readExpensesAndIncome();
//       print(DboperationsblocSuccess(result[0]));
//       emit(DboperationsblocSuccess(result[0]));
//     } catch (error) {
//       emit(DboperationsblocFailure(error.toString()));
//     }
//   }
//   Future<void> _insertTransaction(date, amount, type, note) async {
// //stuck in here there is no way this is not refreshing the state directly
//     String insertUsAccTransactionQuery = """
//     INSERT INTO $transactionTableRM (
//           ${TransactionFieldsRM.date},
//           ${TransactionFieldsRM.amount},
//           ${TransactionFieldsRM.type},
//           ${TransactionFieldsRM.note},
//           ${TransactionFieldsRM.idCategory},
//           ${TransactionFieldsRM.idBankAccount},
//           ${TransactionFieldsRM.idBankAccountTransfer},
//           ${TransactionFieldsRM.recurring},
//           ${TransactionFieldsRM.recurrencyType},
//           ${TransactionFieldsRM.recurrencyPayDay},
//           ${TransactionFieldsRM.recurrencyFrom},
//           ${TransactionFieldsRM.recurrencyTo},
//           ${TransactionFieldsRM.createdAt},
//           ${TransactionFieldsRM.updatedAt}
//     ) VALUES (
//       '$date', '$amount', '$type', '$note', 'idCategory_value',
//       'idBankAccount_value', 'idBankAccountTransfer_value', '0',
//       'recurrencyType_value', 'recurrencyPayDay_value', 'recurrencyFrom_value',
//       'recurrencyTo_value', 'createdAt_value', 'updatedAt_value'
//     );
//   """;

//     await SqlDb.instance.insertData(insertUsAccTransactionQuery);
//   }

  void insertData() async {
    emit(AddingTransactionblocLoading());
    try {
      await _insertIntoDatabase();
      final result = await _readExpensesAndIncome();
            final resultrtrt = await SqlDb.instance.fetchTransactions();
      print(resultrtrt);
      print(AddingTransactionblocSuccess(result[0],resultrtrt));
      emit(AddingTransactionblocSuccess(result[0],resultrtrt));
    } catch (error) {
      emit(AddingTransactionblocFailure(error.toString()));
    }
  }

  Future<void> _insertIntoDatabase() async {
    String insertCategory = """
    INSERT INTO $categoryTransactionTableRM (
          ${CategoryTransactionFieldsRM.name},
          ${CategoryTransactionFieldsRM.symbol},
          ${CategoryTransactionFieldsRM.color},
          ${CategoryTransactionFieldsRM.note},
          ${CategoryTransactionFieldsRM.parent},
          ${CategoryTransactionFieldsRM.createdAt},
          ${CategoryTransactionFieldsRM.updatedAt}
    ) VALUES (
      'name', 'symbol', 'color', 'note_value', 'parent',
      'createdAt', 'updatedAt'
    );
  """;

    String insertQueryFinancialAccount = """INSERT INTO $bankAccountTableRM (
          ${BankAccountFieldsRM.name},
          ${BankAccountFieldsRM.symbol},
          ${BankAccountFieldsRM.color},
          ${BankAccountFieldsRM.startingValue},
          ${BankAccountFieldsRM.active},
          ${BankAccountFieldsRM.mainAccount},
          ${BankAccountFieldsRM.createdAt},
          ${BankAccountFieldsRM.updatedAt}
    ) VALUES (
      '0', '0','0','0','0','0','0','0'
    );
  """;

    String insertUsAccTransactionQuery = """
    INSERT INTO $transactionTableRM (
          ${TransactionFieldsRM.date},
          ${TransactionFieldsRM.amount},
          ${TransactionFieldsRM.type},
          ${TransactionFieldsRM.note},
          ${TransactionFieldsRM.idCategory},
          ${TransactionFieldsRM.idBankAccount},
          ${TransactionFieldsRM.idBankAccountTransfer},
          ${TransactionFieldsRM.recurring},
          ${TransactionFieldsRM.recurrencyType},
          ${TransactionFieldsRM.recurrencyPayDay},
          ${TransactionFieldsRM.recurrencyFrom},
          ${TransactionFieldsRM.recurrencyTo},
          ${TransactionFieldsRM.createdAt},
          ${TransactionFieldsRM.updatedAt}
    ) VALUES (
      'date_value', '500', '${TransactionFieldsRM.typeIncome}', 'note_value', 'idCategory_value',
      'idBankAccount_value', 'idBankAccountTransfer_value', '0',
      'recurrencyType_value', 'recurrencyPayDay_value', 'recurrencyFrom_value',
      'recurrencyTo_value', 'createdAt_value', 'updatedAt_value'
    );
  """;
    await SqlDb.instance.insertData(insertCategory);
    await SqlDb.instance.insertData(insertQueryFinancialAccount);
    await SqlDb.instance.insertData(insertUsAccTransactionQuery);
  }
}

// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import '../../dboperations/DealWithDataBase.dart';

// part 'dboperationsbloc_state.dart';

// class DboperationsblocCubit extends Cubit<DboperationsblocState> {
//   DboperationsblocCubit() : super(DboperationsblocLoading()) {
//     // Trigger the database operation immediately when the Cubit is created
//     _initialize();
//   }

//   void _initialize() async {
//     try {
//       final result = await fetchDataFromDatabase();
//       emit(DboperationsblocSuccess(result));
//     } catch (error) {
//       emit(DboperationsblocFailure(error.toString()));
//     }
//   }

//   Future<String> fetchDataFromDatabase() async {
//     List<Map> readTableRes = await SqlDb.instance.readTableData("totals");
//     print(readTableRes.toString());
//     return readTableRes.toString();
//   }
// }