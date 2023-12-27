import 'dart:async';

import 'package:lechoix/features/categories/data/datasources/CategoriesRepo.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../data/CategoryModel.dart';

class GenderSelectionBloc extends BaseBloc {
  final CategoriesRepo _repo = CategoriesRepo();

  GenderSelectionBloc(super.view) {
    getCategories();
  }

  StreamController<List<CategoryModel>?> controller = StreamController();

  void getCategories() {
    controller.add(null);
    _repo.getCategories({
      "type": "2",
      "in_home": "1",
    }).then((baseResponse) {
      if (baseResponse.data?.dataList?.isNotEmpty == true) {
        List<CategoryModel> dataList = baseResponse.data?.dataList ?? [];
        dataList.insert(0, CategoryModel());
        controller.add(dataList);
      }
    }).onError((error, stackTrace) {
      handleStreamError(error, controller);
    });
  }

  @override
  void onDispose() {
    controller.close();
    _repo.dispose();
  }
}
