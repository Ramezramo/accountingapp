import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../dboperations/DealWithDataBase.dart';
import '../../../../../dboperations/financialaccount.dart';

part 'bank_account_state.dart';

class BankAccountCubit extends Cubit<BankAccountState> {
  BankAccountCubit() : super(BankAccountInitial()) {
    readAllAccounts();
  }

  void readAllAccounts() async {
    try {
      emit(AddingBankAccountblocLoading1());
      List<BankAccountRM>? accountsList =
          await SqlDb.instance.selectAllAccounts();
      List<BankAccountRM>? reversedAccountsList =
          accountsList?.reversed.toList();
      if (reversedAccountsList != null) {
        for (var account in reversedAccountsList) {
          // Perform actions with each account
          print(account.id); // Replace this with your desired operation
        }
      }
      emit(AddingBankAccountblocSuccess1(reversedAccountsList));
    } catch (error) {
      emit(AddingBankAccountlocFailure1(error.toString()));
    }
  }

  Future<void> insertBankAccount(BankAccountRM item) async {
    emit(AddingBankAccountblocLoading1());

    try {
      print(item.toJson());
      final result = await SqlDb.instance.insertBankAccount(item, true);
      print(result);
      List<BankAccountRM>? accountsList =
          await SqlDb.instance.selectAllAccounts();
      List<BankAccountRM>? reversedAccountsList =
          accountsList?.reversed.toList();
      // if (reversedAccountsList != null) {
      //   for (var account in reversedAccountsList) {
      //     // Perform actions with each account
      //     print(account.id); 
      //   }
      // }
      emit(AddingBankAccountblocSuccess1(reversedAccountsList));
    } catch (error) {
      print(error);
      emit(AddingBankAccountlocFailure1(error.toString()));
    }
  }
}
