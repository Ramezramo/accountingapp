part of 'trans_fetcher_cubit.dart';

@immutable
sealed class TransFetcherState {}

final class TransFetcherInitial extends TransFetcherState {}
class TransactionFblocLoading extends TransFetcherState {}

class TransactionFblocSuccess extends TransFetcherState {
  final List<TransactionRM>? result;

  TransactionFblocSuccess(this.result);
}
class TransactionFlocFailure extends TransFetcherState {
  final String error;

  TransactionFlocFailure(this.error);
}

