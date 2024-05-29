part of 'dboperationsbloc_cubit.dart';

@immutable
sealed class DboperationsblocState {}

final class DboperationsblocInitial extends DboperationsblocState {}
final class Success extends DboperationsblocState {}


class DboperationsblocLoading extends DboperationsblocState {}

class DboperationsblocSuccess extends DboperationsblocState {
  final Map result;

  DboperationsblocSuccess(this.result);
}

class DboperationsblocFailure extends DboperationsblocState {
  final String error;

  DboperationsblocFailure(this.error);
}
