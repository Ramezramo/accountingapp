import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/constants.dart';
// import '../model/bank_account.dart';
import 'package:fl_chart/fl_chart.dart';

// import '../model/ol_fls/bank_account.dart';
import '../model/ol_fls/bank_account.dart';
// import '../newdfiles/bloc/cubit/dboperationsbloc_cubit.dart';
import '../newdfiles/bloc/cubit/cubit/bankAccount/cubit/bank_account_cubit.dart';
import '../newdfiles/bloc/cubit/cubit/general/dboperationsbloc_cubit.dart';
import '../newdfiles/dboperations/DealWithDataBase.dart';
import '../newdfiles/dboperations/financialaccount.dart';

final mainAccountProvider = StateProvider<BankAccountRM?>((ref) => null);

final selectedAccountProvider = StateProvider<BankAccountRM?>((ref) => null);
final accountIconProvider =
    StateProvider<String>((ref) => accountIconList.keys.first);
final accountColorProvider = StateProvider<int>((ref) => 0);
final accountMainSwitchProvider = StateProvider<bool>((ref) => false);
final countNetWorthSwitchProvider = StateProvider<bool>((ref) => true);
final selectedAccountCurrentMonthDailyBalanceProvider =
    StateProvider<List<FlSpot>>((ref) => const []);
final selectedAccountLastTransactions = StateProvider<List>((ref) => const []);
final filterAccountProvider = StateProvider<Map<int, bool>>((ref) => {});

class AsyncAccountsNotifier extends AsyncNotifier<List<BankAccountRM>> {
  @override
  Future<List<BankAccountRM>> build() async {
    ref.watch(mainAccountProvider.notifier).state = await _getMainAccount();
    List<BankAccountRM> accounts = await _getAccounts();

    for (BankAccountRM account in accounts) {
      ref.watch(filterAccountProvider.notifier).state[account.id!] = false;
    }

    return accounts;
  }

  Future<List<BankAccountRM>> _getAccounts() async {
    final accounts = await BankAccountMethods().selectAll();
    return accounts;
  }

  Future<BankAccountRM?> _getMainAccount() async {
    final account = await BankAccountMethods().selectMain();
    return account;
  }

  Future<void> addAccount(context, String name, num? startingValue) async {
    BankAccountRM account = BankAccountRM(
      name: name,
      symbol: ref.read(accountIconProvider),
      color: ref.read(accountColorProvider),
      startingValue: startingValue ?? 0,
      active: ref.read(countNetWorthSwitchProvider),
      mainAccount: ref.read(accountMainSwitchProvider),
    );
    context.read<BankAccountCubit>().insertBankAccount(account);

    // state = const AsyncValue.loading();
    // state = await AsyncValue.guard(() async {
    //   await BankAccountMethods().insert(account);
    //   return _getAccounts();
    // });
  }

  Future<void> updateAccount(String name) async {
    // BankAccount account = ref.read(selectedAccountProvider)!.copy(
    //       name: name,
    //       symbol: ref.read(accountIconProvider),
    //       color: ref.read(accountColorProvider),
    //       active: ref.read(countNetWorthSwitchProvider),
    //       mainAccount: ref.read(accountMainSwitchProvider),
    //     );

    // state = const AsyncValue.loading();
    // state = await AsyncValue.guard(() async {
    //   await BankAccountMethods().updateItem(account);
    //   if (account.mainAccount) {
    //     ref.read(mainAccountProvider.notifier).state = account;
    //   }
    //   return _getAccounts();
    // });
  }
Future<void> selectedAccount(BankAccountRM account) async {
  // Update various providers with account information
  ref.read(selectedAccountProvider.notifier).state = account;
  ref.read(accountIconProvider.notifier).state = account.symbol;
  ref.read(accountColorProvider.notifier).state = account.color;
  ref.read(accountMainSwitchProvider.notifier).state = account.mainAccount;

  // Get the daily balance for the current month
  final currentMonthDailyBalance = await SqlDb.instance.accountDailyBalance(
    account.id!,
    dateRangeStart: DateTime(DateTime.now().year, DateTime.now().month, 1), // Beginning of current month
    dateRangeEnd: DateTime(DateTime.now().year, DateTime.now().month + 1, 1), // Beginning of next month
  );

  // Convert the daily balance to FlSpot objects
  ref.read(selectedAccountCurrentMonthDailyBalanceProvider.notifier).state =
    currentMonthDailyBalance!.map((e) {
      final day = e['day'] as String;
      final balance = e['balance'] as num;
      return FlSpot(
        double.parse(day.substring(8)) - 1,
        balance.toDouble(),
      );
    }).toList();

  // Get the last 50 transactions for the account
  ref.read(selectedAccountLastTransactions.notifier).state =
    await BankAccountMethods().getTransactions(account.id!, 50);
}
  // Future<void> selectedAccount(BankAccountRM account) async {
  //   ref.read(selectedAccountProvider.notifier).state = account;
  //   ref.read(accountIconProvider.notifier).state = account.symbol;
  //   ref.read(accountColorProvider.notifier).state = account.color;
  //   ref.read(accountMainSwitchProvider.notifier).state = account.mainAccount;

  //   final currentMonthDailyBalance = await SqlDb.instance.accountDailyBalance(
  //       account.id!,
  //       dateRangeStart: DateTime(DateTime.now().year, DateTime.now().month,
  //           1), // beginnig of current month
  //       dateRangeEnd: DateTime(DateTime.now().year, DateTime.now().month + 1,
  //           1) // beginnig of next month
  //       );

  //   ref.read(selectedAccountCurrentMonthDailyBalanceProvider.notifier).state =
  //       currentMonthDailyBalance!.map((e) {
  //     return FlSpot(double.parse(e['day'].substring(8)) - 1,
  //         double.parse(e['balance'].toStringAsFixed(2)));
  //   }).toList();

  //   ref.read(selectedAccountLastTransactions.notifier).state =
  //       await BankAccountMethods().getTransactions(account.id!, 50);
  // }

  Future<void> removeAccount(int accountId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await BankAccountMethods().deactivateById(accountId);
      return _getAccounts();
    });
  }

  void reset() {
    ref.invalidate(selectedAccountProvider);
    ref.invalidate(selectedAccountCurrentMonthDailyBalanceProvider);
    ref.invalidate(accountIconProvider);
    ref.invalidate(accountColorProvider);
    ref.invalidate(accountMainSwitchProvider);
    ref.invalidate(countNetWorthSwitchProvider);
  }
}

final accountsProvider =
    AsyncNotifierProvider<AsyncAccountsNotifier, List<BankAccountRM>>(() {
  return AsyncAccountsNotifier();
});
