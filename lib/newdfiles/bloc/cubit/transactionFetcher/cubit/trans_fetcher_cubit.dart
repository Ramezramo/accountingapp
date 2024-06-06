import 'package:accounting_app_last/newdfiles/dboperations/transaction_object.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../dboperations/DealWithDataBase.dart';

part 'trans_fetcher_state.dart';

class TransFetcherCubit extends Cubit<TransFetcherState> {
  TransFetcherCubit() : super(TransFetcherInitial()) {
    readAllTransactions();
  }
  Future<void> readAllTransactions() async {
    emit(TransactionFblocLoading());
    try {
      final result = await SqlDb.instance.fetchTransactions();
      print(result);

      emit(TransactionFblocSuccess(result));
    } catch (error) {
      print(error);
      emit(TransactionFlocFailure(error.toString()));
    }
  }
}
