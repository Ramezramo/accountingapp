import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../constants/functions.dart';
import '../../../constants/style.dart';

import '../../../model/ol_fls/bank_account.dart';
import '../../../newdfiles/bloc/cubit/cubit/bankAccount/cubit/bank_account_cubit.dart';
import '../../../newdfiles/bloc/cubit/cubit/general/dboperationsbloc_cubit.dart';

import '../../../newdfiles/dboperations/DealWithDataBase.dart';
import '../../../newdfiles/dboperations/financialaccount.dart';
import '../../../providers/accounts_provider.dart';

class AccountSelector extends ConsumerStatefulWidget {
  const AccountSelector({
    required this.provider,
    required this.scrollController,
    this.fromAccount,
    super.key,
  });

  final StateProvider provider;
  final ScrollController scrollController;
  final int? fromAccount;

  @override
  ConsumerState<AccountSelector> createState() => _AccountSelectorState();
}

class _AccountSelectorState extends ConsumerState<AccountSelector>
    with Functions {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          title: const Text("Account"),
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).pushNamed('/add-account'),
              icon: const Icon(Icons.add_circle),
              splashRadius: 28,
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: widget.scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 16, top: 32, bottom: 8),
                  child: Text(
                    "MORE FREQUENT",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                BlocConsumer<BankAccountCubit, BankAccountState>(
                  listener: (context, state) async {


                  },
                  builder: (context, state) {
                    if (state is AddingBankAccountblocLoading1) {

                      return const CircularProgressIndicator();
                    } else if (state is AddingBankAccountblocSuccess1) {

                      final accounts = state.result;
                      print(accounts);
                      return AccountsViewer(
                          accounts: accounts!, ref: ref, widget: widget);
                    } else if (state is AddingBankAccountlocFailure1) {

                      return Text('Error: ${state.error}',
                          style: const TextStyle(color: Colors.red));
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SecondListViewViewingTheAccounts extends StatelessWidget {
  const SecondListViewViewingTheAccounts({
    super.key,
    required this.accounts,
    required this.ref,
    required this.widget,
  });

  final List<BankAccountRM> accounts;
  final WidgetRef ref;
  final AccountSelector widget;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: accounts.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) =>
          const Divider(height: 1, color: grey1),
      itemBuilder: (context, i) {
        BankAccountRM account = accounts[i];
        IconData? icon = accountIconList[account.symbol];
        Color? color = accountColorListTheme[account.color];
        return ListTile(
          onTap: () => ref.read(widget.provider.notifier).state = account,
          enabled: account.id != widget.fromAccount,
          leading: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            padding: const EdgeInsets.all(10.0),
            child: icon != null
                ? Icon(
                    icon,
                    size: 24.0,
                    color: Theme.of(context).colorScheme.background,
                  )
                : const SizedBox(),
          ),
          title: Text(account.name),
          trailing: (ref.watch(widget.provider)?.id == account.id)
              ? Icon(
                  Icons.done,
                  color: Theme.of(context).colorScheme.secondary,
                )
              : null,
        );
      },
    );
  }
}

class AccountsViewer extends StatelessWidget {
  const AccountsViewer({
    super.key,
    required this.accounts,
    required this.ref,
    required this.widget,
  });

  final List<BankAccountRM> accounts;
  final WidgetRef ref;
  final AccountSelector widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Theme.of(context).colorScheme.surface,
          height: 74,
          width: double.infinity,
          child: ListView.builder(
            itemCount: (accounts.length > 6) ? 6 : accounts.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              try {
                BankAccountRM account = accounts[i];
                IconData? icon = accountIconList[account.symbol];
                Color? color = accountColorListTheme[account.color];
                return GestureDetector(
                  onTap: () => {
                    ref.read(widget.provider.notifier).state = account,
                    Navigator.of(context).pop(),
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color,
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: icon != null
                              ? Icon(
                                  icon,
                                  size: 24.0,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                )
                              : const SizedBox(),
                        ),
                        Text(
                          account.name,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                  ),
                );
              } catch (e) {
                return const SizedBox();
              }
            },
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 16, top: 32, bottom: 8),
          child: Text(
            "ALL ACCOUNTS",
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        SecondListViewViewingTheAccounts(
            accounts: accounts, ref: ref, widget: widget),
      ],
    );
  }
}
