import 'dart:async';

import 'package:lechoix/data/Enumeration.dart';
import 'package:lechoix/features/categories/data/datasources/CategoriesRepo.dart';
import 'package:lechoix/features/filter/data/datasources/FiltrationRepo.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../data/CategoryModel.dart';
import '../../../../data/filtration/FiltrationDataModel.dart';
import '../../../../data/filtration/Response/DataList.dart';

class FiltrationBloc extends BaseBloc {
  // PROPERTIES
  final CategoriesRepo _categoriesRepo = CategoriesRepo();
  final FiltrationRepo _filtrationRepo = FiltrationRepo();

  List<FiltrationDataModel> resultList = [];

  // OUTPUT
  StreamController<List<FiltrationDataModel>> controller = StreamController();

  // InPUT
  final FiltrationType type;
  List<int> ids;
  int categoryId;
  int brandId;

  FiltrationBloc(
      super.view, this.type, this.ids, this.categoryId, this.brandId) {
    getData();
  }

  updateSelectedOptions(FiltrationDataModel model) {
    model.isSelected = !model.isSelected;
    if (model.isSelected) {
      ids.add(model.id);
    } else {
      ids.remove(model.id);
    }
    resultList[resultList.indexWhere((element) => element.id == model.id)] =
        model;
    controller.add(resultList);
  }

  clear() {
    ids = [];
    for (var element in resultList) {
      element.isSelected = false;
    }
    controller.add(resultList);
  }

  getData() {
    resultList = [];
    switch (type) {
      case FiltrationType.categories:
        {
          getCategories().then((dataList) => {
                dataList?.forEach((model) {
                  resultList.add(FiltrationDataModel.Category(model, ids));
                }),
                controller.add(resultList)
              });
        }
        break;

      case FiltrationType.colors:
        {
          getFiltrationData().then((dataList) => {
                dataList?.forEach((model) {
                  resultList.add(FiltrationDataModel.Color(model, ids));
                }),
                controller.add(resultList)
              });
        }
        break;

      default:
        {
          getFiltrationData().then((dataList) => {
                dataList?.forEach((model) {
                  resultList
                      .add(FiltrationDataModel.FiltrationModel(model, ids));
                }),
                controller.add(resultList)
              });
        }
        break;
    }
  }

  Future<List<CategoryModel>?> getCategories() async {
    try {
      var baseResponse = await _categoriesRepo.getCategories(getParam());
      return baseResponse.data?.dataList;
    } catch (e) {
      handleError(e);
    }
    return null;
  }

  Future<List<FiltrationModel>?> getFiltrationData() async {
    try {
      var baseResponse =
          await _filtrationRepo.getFiltrationData(type, getParam());
      return baseResponse.data?.dataList;
    } catch (e) {
      handleError(e);
    }
    return null;
  }

  Map<String, dynamic> getParam() {
    final param = <String, dynamic>{};
    if (categoryId != -1) {
      param["category_id"] = categoryId;
    }
    if (brandId != -1) {
      param["brand_id"] = brandId;
    }

    return param;
  }

  @override
  void onDispose() {
    controller.close();
    _categoriesRepo.dispose();
    _filtrationRepo.dispose();
  }
}
