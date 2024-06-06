import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../constants/functions.dart';
import '../../../constants/style.dart';
// import '../../../model/category_transaction.dart';
import '../../../model/ol_fls/category_transaction.dart';
// import '../../../newdfiles/bloc/cubit/dboperationsbloc_cubit.dart';
import '../../../newdfiles/bloc/cubit/cubit/general/dboperationsbloc_cubit.dart';
import '../../../newdfiles/dboperations/DealWithDataBase.dart';
import '../../../newdfiles/dboperations/categoryobject.dart';
import '../../../providers/categories_provider.dart';
import '../../../providers/transactions_provider.dart';

class CategorySelector extends ConsumerStatefulWidget {
  const CategorySelector({
    required this.scrollController,
    super.key,
  });

  final ScrollController scrollController;

  @override
  ConsumerState<CategorySelector> createState() => _CategorySelectorState();
}
class _CategorySelectorState extends ConsumerState<CategorySelector>
    with Functions {
  List<CategoryTransactionRM> categories = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      var categoriesList = await SqlDb.instance.selectAllCategories();
      setState(() {
        categories = categoriesList;
        isLoading = false;
        error = null;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          title: const Text("Category"),
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).pushNamed('/add-category'),
              icon: const Icon(Icons.add_circle),
              splashRadius: 28,
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: widget.scrollController,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 16, top: 32, bottom: 8),
                  child: Text(
                    "MORE FREQUENT",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                BlocListener<DboperationsblocCubit, DboperationsblocState>(
                  listener: (context, state) async {
                    await fetchCategories();
                  },
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : error != null
                          ? Text('Error: $error')
                          : Container(
                              color: Theme.of(context).colorScheme.surface,
                              height: 74,
                              width: double.infinity,
                              child: ListView.builder(
                                itemCount: categories.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, i) {
                                  try {
                                    CategoryTransactionRM category = categories[i];
                                    IconData? icon = iconList[category.symbol];
                                    Color? color = categoryColorListTheme[category.color];
                                    return GestureDetector(
                                      onTap: () => {
                                        ref.read(categoryProvider.notifier).state = category,
                                        Navigator.of(context).pop(),
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: color,
                                              ),
                                              padding: const EdgeInsets.all(10.0),
                                              child: icon != null
                                                  ? Icon(
                                                      icon,
                                                      size: 24.0,
                                                      color: Theme.of(context).colorScheme.background,
                                                    )
                                                  : const SizedBox(),
                                            ),
                                            Text(
                                              category.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(color: Theme.of(context).colorScheme.primary),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } catch (e) {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 16, top: 32, bottom: 8),
                  child: Text(
                    "ALL CATEGORIES",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : error != null
                        ? Text('Error: $error')
                        : ListView.separated(
                            itemCount: categories.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => const Divider(height: 1, color: grey1),
                            itemBuilder: (context, i) {
                              CategoryTransactionRM category = categories[i];
                              IconData? icon = iconList[category.symbol];
                              Color? color = categoryColorListTheme[category.color];
                              return ListTile(
                                onTap: () => ref.read(categoryProvider.notifier).state = category,
                                leading: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: color,
                                  ),
                                  padding: const EdgeInsets.all(10.0),
                                  child: icon != null
                                      ? Icon(
                                          icon,
                                          size: 24.0,
                                          color: Theme.of(context).colorScheme.background,
                                        )
                                      : const SizedBox(),
                                ),
                                title: Text(category.name),
                                trailing: ref.watch(categoryProvider)?.id == category.id
                                    ? Icon(
                                        Icons.done,
                                        color: Theme.of(context).colorScheme.secondary,
                                      )
                                    : null,
                              );
                            },
                          ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}