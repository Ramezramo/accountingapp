// Defines application's structure

import 'package:accounting_app_last/newdfiles/dboperations/DealWithDataBase.dart';
import 'package:accounting_app_last/newdfiles/dboperations/financialaccount.dart';
import 'package:accounting_app_last/newdfiles/dboperations/transaction_object.dart';
import 'package:accounting_app_last/model/ol_fls/category_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import '../newdfiles/bloc/cubit/dboperationsbloc_cubit.dart';
import '../newdfiles/dboperations/categoryobject.dart';
import '../newdfiles/pages/testCubitPage/cubitpagetest.dart';
import '../providers/transactions_provider.dart';
import 'calculate_Income.dart';
import 'planning_page/planning_page.dart';
import 'statistics_page.dart';
import 'transactions_page/transactions_page.dart';

final StateProvider selectedIndexProvider = StateProvider<int>((ref) => 0);

class Structure extends ConsumerStatefulWidget {
  const Structure({super.key});

  @override
  ConsumerState<Structure> createState() => _StructureState();
}

void insert(context) async {
//   String insertCategory = """
//   INSERT INTO $categoryTransactionTableRM (
//         ${CategoryTransactionFieldsRM.name},
//         ${CategoryTransactionFieldsRM.symbol},
//         ${CategoryTransactionFieldsRM.color},
//         ${CategoryTransactionFieldsRM.note},
//         ${CategoryTransactionFieldsRM.parent},
//         ${CategoryTransactionFieldsRM.createdAt},
//         ${CategoryTransactionFieldsRM.updatedAt}
//   ) VALUES (
//     'name', 'symbol', 'color', 'note_value', 'parent',
//     'createdAt', 'updatedAt'
//   );
// """;

//   String insertQueryFinancialAccount = """INSERT INTO $bankAccountTableRM (
//         ${BankAccountFieldsRM.name},
//         ${BankAccountFieldsRM.symbol},
//         ${BankAccountFieldsRM.color},
//         ${BankAccountFieldsRM.startingValue},
//         ${BankAccountFieldsRM.active},
//         ${BankAccountFieldsRM.mainAccount},
//         ${BankAccountFieldsRM.createdAt},
//         ${BankAccountFieldsRM.updatedAt}
//   ) VALUES (
//     '0', '0','0','0','0','0','0','0'
//   );
// """;

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
//     'date_value', '500', '${TransactionFieldsRM.typeIncome}', 'note_value', 'idCategory_value',
//     'idBankAccount_value', 'idBankAccountTransfer_value', '0',
//     'recurrencyType_value', 'recurrencyPayDay_value', 'recurrencyFrom_value',
//     'recurrencyTo_value', 'createdAt_value', 'updatedAt_value'
//   );
// """;
// await SqlDb.instance.insertData(insertCategory);
//   await SqlDb.instance.insertData(insertQueryFinancialAccount);
//   await SqlDb.instance.insertData(insertUsAccTransactionQuery);
//   await SqlDb.instance.updateTotals();
//   List<Map> readTableRes =
//       await SqlDb.instance.readTableData("totals");
//   // Future<int>? delResponse = await SqlDb.instance.deleteData(2, "notes");
//   // // Wait for the result of deleteData and assign it to delResponse
//   // int upRes = await SqlDb.instance.updateData(
//   //     "UPDATE 'UsAccTransaction' SET 'transaction_type' = 'RAMEZ UPDATED YOU MF' WHERE id = 86");
//   // SqlDb.instance.deleteTable("UsAccTransaction");
//   // int? result = await delResponse; // Wait for the result of delResponse

//   print(readTableRes);
//   // print(response);
//   // print("Delete value: $result");

//   await SqlDb.instance.getRowById("UsAccTransaction", 86);
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DbOperationsScreen()),
  );
}

class _StructureState extends ConsumerState<Structure> {
  // We could add this List in the app's state, so it isn't intialized every time.
  final List<String> _pagesTitle = [
    "Dashboard",
    "Transactions",
    "",
    "Planning",
    "Graphs",
  ];
  final List<Widget> _pages = [
    const CalculateIncomeDashboard(),
    const TransactionsPage(),
    const SizedBox(),
    const PlanningPage(),
    const StatsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    return Scaffold(
      // Prevent the fab moving up when the keyboard is opened
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: selectedIndex == 0
            ? Theme.of(context).colorScheme.tertiary
            : Theme.of(context).colorScheme.background,
        title: Text(
          _pagesTitle.elementAt(selectedIndex),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: ElevatedButton(
            // onPressed: () => Navigator.of(context).pushNamed('/search'),
            onPressed: () {
              final date = ref.read(dateProvider);
              
              //           context.read<DboperationsblocCubit>().insertTransaction(
              // date, 50, TransactionFieldsRM.typeExpenses, "note");
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(8),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed('/settings'),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(8),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: _pages[selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 8,
        unselectedFontSize: 8,
        currentIndex: selectedIndex,
        onTap: (index) => index != 2
            ? ref.read(selectedIndexProvider.notifier).state = index
            : null,
        items: [
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 0 ? Icons.home : Icons.home_outlined),
            label: "DASHBOARD",
          ),
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 1
                ? Icons.swap_horizontal_circle
                : Icons.swap_horizontal_circle_outlined),
            label: "TRANSACTIONS",
          ),
          const BottomNavigationBarItem(icon: Text(""), label: ""),
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 3
                ? Icons.calendar_today
                : Icons.calendar_today_outlined),
            label: "PLANNING",
          ),
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 4
                ? Icons.data_exploration
                : Icons.data_exploration_outlined),
            label: "GRAPHS",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        highlightElevation: 0,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(
          Icons.add_rounded,
          size: 55,
          color: Theme.of(context).colorScheme.background,
        ),
        onPressed: () {
          ref.read(transactionsProvider.notifier).reset();
          Navigator.of(context).pushNamed("/add-page");
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
