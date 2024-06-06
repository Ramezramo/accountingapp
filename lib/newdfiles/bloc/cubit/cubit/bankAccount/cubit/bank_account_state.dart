part of 'bank_account_cubit.dart';

@immutable
sealed class BankAccountState {}

final class BankAccountInitial extends BankAccountState {}
class AddingBankAccountblocLoading1 extends BankAccountState {}

class AddingBankAccountblocSuccess1 extends BankAccountState {
  final List<BankAccountRM>? result;

  AddingBankAccountblocSuccess1(this.result);
}
class AddingBankAccountlocFailure1 extends BankAccountState {
  final String error;

  AddingBankAccountlocFailure1(this.error);
}
