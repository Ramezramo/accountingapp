import 'package:accounting_app_last/newdfiles/bloc/cubit/dboperationsbloc_cubit.dart';
import 'package:fl_chart/src/chart/base/axis_chart/axis_chart_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../pages/home_widget/budgets_home.dart';
import '../constants/functions.dart';
import '../constants/style.dart';
import '../custom_widgets/accounts_sum.dart';
import '../custom_widgets/line_chart.dart';
import '../custom_widgets/transactions_list.dart';
// import '../model/bank_account.dart';
import '../model/ol_fls/bank_account.dart';
import '../newdfiles/dboperations/DealWithDataBase.dart';
import '../newdfiles/dboperations/financialaccount.dart';
import '../providers/accounts_provider.dart';
import '../providers/currency_provider.dart';
import '../providers/dashboard_provider.dart';
import '../providers/transactions_provider.dart';

class CalculateIncomeDashboard extends ConsumerStatefulWidget {
  const CalculateIncomeDashboard({super.key});

  @override
  ConsumerState<CalculateIncomeDashboard> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<CalculateIncomeDashboard>
    with Functions {
  @override
  Widget build(BuildContext context) {
    final accountList = ref.watch(accountsProvider);
    final lastTransactions = ref.watch(lastTransactionsProvider);
    final currencyState = ref.watch(currencyStateNotifier);
    print(currencyState.selectedCurrency.symbol);

    final expense = ref.watch(expenseProvider);

    final currentMonthList = ref.watch(currentMonthListProvider);
    final lastMonthList = ref.watch(lastMonthListProvider);
    context.read<DboperationsblocCubit>().readExpensesAndIncome();
    return Container(
      color: Theme.of(context).colorScheme.tertiary,
      child: ListView(
        children: [
          BlocConsumer<DboperationsblocCubit, DboperationsblocState>(
            listener: (context, state) {
              // TODO: implement listener
              print(state);
            },
            builder: (context, state) {
              if (state is AddingTransactionblocLoading) {
                return const CircularProgressIndicator();
              } else if (state is AddingTransactionblocSuccess) {
                print(state.result["income"]);
                final income = state.result["income"];
                final expense = state.result["expenses"];
                final total = income - expense;
                return dashBoardDataSection(context, total, currencyState,
                    income, expense, currentMonthList, lastMonthList);
              } else if (state is AddingTransactionblocFailure) {
                return Text('Error: ${state.error}',
                    style: const TextStyle(color: Colors.red));
              }
              return Container();
            },
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer, //da modificare in darkMode
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Text(
                    "Your accounts",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(
                  height: 86.0,
                  child: accountList.when(
                    data: (accounts) => ListView.builder(
                      itemCount: accounts.length + 1,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        if (i == accounts.length) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 16),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [defaultShadow],
                              ),
                              child: TextButton.icon(
                                style: ButtonStyle(
                                  maximumSize: MaterialStateProperty.all(
                                      const Size(130, 48)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).colorScheme.surface),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                                icon: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: blue5,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.add_rounded,
                                      size: 24.0,
                                      color: white,
                                    ),
                                  ),
                                ),
                                label: Text(
                                  "New Account",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                  maxLines: 2,
                                ),
                                onPressed: () {
                                  ref.read(accountsProvider.notifier).reset();
                                  Navigator.of(context)
                                      .pushNamed('/add-account');
                                },
                              ),
                            ),
                          );
                        } else {
                          BankAccountRM account = accounts[i];
                          return AccountsSum(account: account);
                        }
                      },
                    ),
                    loading: () => const SizedBox(),
                    error: (err, stack) => Text('Error: $err'),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
                    child: Text(
                      "Last transactions",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                lastTransactions.when(
                  data: (transactions) =>
                      TransactionsList(transactions: transactions),
                  loading: () => const SizedBox(),
                  error: (err, stack) => Text('Error: $err'),
                ),
                const SizedBox(height: 28),
                BudgetsSection()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column dashBoardDataSection(
      BuildContext context,
      num total,
      CurrencyState currencyState,
      int income,
      num expense,
      List<FlSpot> currentMonthList,
      List<FlSpot> lastMonthList) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          children: [
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "MONTHLY BALANCE",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: numToCurrency(total),
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.primary),
                      ),
                      TextSpan(
                        text: currencyState.selectedCurrency.symbol,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "INCOME",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: numToCurrency(income),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: green),
                      ),
                      TextSpan(
                        text: currencyState.selectedCurrency.symbol,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: green),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "EXPENSES",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: numToCurrency(expense),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: red),
                      ),
                      TextSpan(
                        text: currencyState.selectedCurrency.symbol,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        LineChartWidget(
          lineData: currentMonthList,
          line2Data: lastMonthList,
        ),
        Row(
          children: [
            const SizedBox(width: 16),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              "Current month",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(width: 12),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: grey2,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              "Last month",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
        const SizedBox(height: 22),
      ],
    );
  }
}
