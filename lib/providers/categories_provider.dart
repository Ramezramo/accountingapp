
import 'package:accounting_app_last/newdfiles/bloc/cubit/dboperationsbloc_cubit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/constants.dart';
import '../model/ol_fls/category_transaction.dart';
import '../newdfiles/dboperations/DealWithDataBase.dart';
import '../newdfiles/dboperations/categoryobject.dart';

final selectedCategoryProvider = StateProvider<CategoryTransactionRM?>((ref) => null);
final categoryIconProvider = StateProvider<String>((ref) => iconList.keys.first);
final categoryColorProvider = StateProvider<int>((ref) => 0);

class AsyncCategoriesNotifier extends AsyncNotifier<List<CategoryTransactionRM>> {
  @override
  Future<List<CategoryTransactionRM>> build() async {
    return _getCategories();
  }

  Future<List<CategoryTransactionRM>> _getCategories() async {
    final categories = await SqlDb.instance.selectAllCategories();
    return categories;
  }

  // Future<void> addCategory(context,String name) async {
  //   // CategoryTransactionRM category = CategoryTransactionRM(
  //   //   name: name,
  //   //   symbol: ref.read(categoryIconProvider),
  //   //   color: ref.read(categoryColorProvider),
  //   // );
  //   // context.read<DboperationsblocCubit>().insertCategory(category);

  //   // state = const AsyncValue.loading();
  //   // state = await AsyncValue.guard(() async {
  //   //   await CategoryTransactionMethods().insert(category);
  //   //   return _getCategories();
  //   // });
  // }

  Future<void> updateCategory(String name) async {
    CategoryTransactionRM category = ref.read(selectedCategoryProvider)!.copy(
      name: name,
      symbol: ref.read(categoryIconProvider),
      color: ref.read(categoryColorProvider),
    );
    
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await CategoryTransactionMethods().updateItem(category);
      return _getCategories();
    });
  }

  void selectedCategory(CategoryTransactionRM category) {
    ref.read(selectedCategoryProvider.notifier).state = category;
    ref.read(categoryIconProvider.notifier).state = category.symbol;
    ref.read(categoryColorProvider.notifier).state = category.color;
  }

  Future<void> removeCategory(int categoryId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await CategoryTransactionMethods().deleteById(categoryId);
      return _getCategories();
    });
  }

  void reset() {
    ref.invalidate(selectedCategoryProvider);
    ref.invalidate(categoryIconProvider);
    ref.invalidate(categoryColorProvider);
  }

  Future<List<CategoryTransactionRM>> getCategories() async {
    return _getCategories();
  }
}

final categoriesProvider = AsyncNotifierProvider<AsyncCategoriesNotifier, List<CategoryTransactionRM>>(() {
  return AsyncCategoriesNotifier();
});
