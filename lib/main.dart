import 'dart:io';
// import 'package:accounting_app_last/newdfiles/bloc/cubit/dboperationsbloc_cubit.dart';
import 'package:accounting_app_last/newdfiles/dboperations/DealWithDataBase.dart';
import 'package:accounting_app_last/newdfiles/dboperations/readFromDBInAnAppropriateShape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:workmanager/workmanager.dart';
import 'package:accounting_app_last/utils/worker_manager.dart';
import 'newdfiles/bloc/cubit/cubit/bankAccount/cubit/bank_account_cubit.dart';
import 'newdfiles/bloc/cubit/cubit/categorey/insert_new_category_cubit.dart';
import 'newdfiles/bloc/cubit/cubit/general/dboperationsbloc_cubit.dart';
import 'newdfiles/bloc/cubit/transactionFetcher/cubit/trans_fetcher_cubit.dart';
import 'pages/notifications/notifications_service.dart';
import 'providers/theme_provider.dart';
import 'routes.dart';
import 'utils/app_theme.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    SqlDb.instance.database;
    // insert();

    requestNotificationPermissions();
    initializeNotifications();
    Workmanager().initialize(callbackDispatcher);
  }
  initializeDateFormatting('it_IT', null)
      .then((_) => runApp(const ProviderScope(child: Launcher())));
}

class Launcher extends ConsumerWidget {
  const Launcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DboperationsblocCubit()..readExpensesAndIncome(),
        ),

        BlocProvider(
          create: (context) => BankAccountCubit()..readAllAccounts() ,
        ),

        BlocProvider(
          create: (context) => InsertNewCategoryCubit(),
        ),
                BlocProvider(
          create: (context) => TransFetcherCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'AppName',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: appThemeState.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
        onGenerateRoute: makeRoute,
        initialRoute: '/',
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'dboperationsbloc_cubit.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => DboperationsblocCubit(),
//       child: MaterialApp(
//         home: DbOperationsScreen(),
//       ),
//     );
//   }
// }