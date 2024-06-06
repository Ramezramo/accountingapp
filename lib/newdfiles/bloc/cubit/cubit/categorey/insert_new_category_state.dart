part of 'insert_new_category_cubit.dart';

@immutable
sealed class InsertNewCategoryState {}

final class InsertNewCategoryInitial extends InsertNewCategoryState {}
class AddingCategoryblocLoading extends InsertNewCategoryState {}
class AddingCategoryblocSuccess extends InsertNewCategoryState {
  var result;

  AddingCategoryblocSuccess(this.result);
}
class AddingCategoryBlocFailure extends InsertNewCategoryState {
  final String error;

  AddingCategoryBlocFailure(this.error);
}