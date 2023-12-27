import 'dart:async';
import 'dart:developer';

import 'package:lechoix/features/categories/data/datasources/CategoriesRepo.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/cache/user_cache.dart';
import '../../../../data/CategoryModel.dart';

class CategoriesBloc extends BaseBloc {
  CategoriesBloc(super.view) {
    getCategories();
  }

  final CategoriesRepo _categoriesRepo = CategoriesRepo();
  StreamController<List<CategoryModel>?> categoriesController =
      StreamController();

  void getCategories() {
    categoriesController.add(null);
    _categoriesRepo.getCategories({
      "type": "2",
      "limit": "100",
      "with": "subcategories",
      "homeOLD": 1,
    }).then((response) {
      log("response $response");
      var mainCategoryID = UserCache.instance.getCategoryId();
      var originList = response.data?.dataList ?? [];
      List<CategoryModel> sortedList = [];

      for (int i = 0; i < originList.length; i++) {
        if (originList[i].id == mainCategoryID) {
          sortedList.add(originList[i]);
          originList.removeAt(i);
          break;
        }
      }
      sortedList.addAll(originList);

      categoriesController.add(sortedList);
    }).onError((error, stackTrace) {
      handleStreamError(error, categoriesController);
    });
  }

  @override
  void onDispose() {
    _categoriesRepo.dispose();
    categoriesController.close();
  }
}
