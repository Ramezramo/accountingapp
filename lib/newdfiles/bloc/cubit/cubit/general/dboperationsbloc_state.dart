part of 'dboperationsbloc_cubit.dart';

@immutable
sealed class DboperationsblocState {}

final class DboperationsblocInitial extends DboperationsblocState {}

final class Success extends DboperationsblocState {}

// loading
class AddingTransactionblocLoading extends DboperationsblocState {}

class AddingBankAccountblocLoading extends DboperationsblocState {}

class AddingCategoryblocLoading extends DboperationsblocState {}

// success
class AddingTransactionblocSuccess extends DboperationsblocState {
  var result;
  var transactionsOboject;

  AddingTransactionblocSuccess(this.result,this.transactionsOboject);
}
// class TransactionFblocSuccess extends DboperationsblocState {
//   final List<TransactionRM>? result;

//   TransactionFblocSuccess(this.result);
// }

class AddingBankAccountblocSuccess extends DboperationsblocState {
  final Map result;

  AddingBankAccountblocSuccess(this.result);
}

class AddingCategoryblocSuccess extends DboperationsblocState {
  var result;

  AddingCategoryblocSuccess(this.result);
}

// failure
class AddingTransactionblocFailure extends DboperationsblocState {
  final String error;

  AddingTransactionblocFailure(this.error);
}

class AddingBankAccountlocFailure extends DboperationsblocState {
  final String error;

  AddingBankAccountlocFailure(this.error);
}

class AddingCategoryBlocFailure extends DboperationsblocState {
  final String error;

  AddingCategoryBlocFailure(this.error);
}
