import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../dboperations/DealWithDataBase.dart';
import '../../../../dboperations/categoryobject.dart';
// import '../../../dboperations/DealWithDataBase.dart';
// import '../../../dboperations/categoryobject.dart';

part 'insert_new_category_state.dart';

class InsertNewCategoryCubit extends Cubit<InsertNewCategoryState> {
  InsertNewCategoryCubit() : super(InsertNewCategoryInitial());

    Future<void> insertCategory(CategoryTransactionRM item) async {
    emit(AddingCategoryblocLoading());
    try {
      print(item.toJson());
      final result = await SqlDb.instance.insertCategoryDB(item,true);
      print(result);
      
     
      emit(AddingCategoryblocSuccess(""));
    } catch (error) {
      print(error);
      emit(AddingCategoryBlocFailure(error.toString()));
    }
  }
}
