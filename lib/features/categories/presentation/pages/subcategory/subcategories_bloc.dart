import 'dart:async';
import 'dart:developer';

import 'package:lechoix/features/product/data/datasources/ProductsRepo.dart';

import '../../../../../core/base/base_bloc.dart';
import '../../../../../data/filtration/FiltrationCriteriaModel.dart';
import '../../../../../data/model/PaginationModel.dart';
import '../../../../../data/model/ProductModel.dart';
import '../../../../../data/pair.dart';
import '../../../../../data/response/ProductsResponse.dart';

class SubcategoriesBloc extends BaseBloc {
  SubcategoriesBloc(super.view);

  final ProductsRepo _productsRepo = ProductsRepo();

  StreamController<Pair<List<ProductModel>, PaginationModel>?>
      productsController = StreamController();

  ProductsResponse? _productsResponse;

  FiltrationCriteriaModel filtrationModel = FiltrationCriteriaModel();

  bool _isLoading = false;

  void setFiltrationModel(FiltrationCriteriaModel filtrationModel) {
    this.filtrationModel = filtrationModel;
  }

  void clearAllData() {
    _productsResponse = null;
    // filtrationModel.clear();
    productsController.add(null);
  }

  void getProducts({int page = 1}) {
    _isLoading = true;
    log("PAGE: $page");
    if (page == 1) {
      productsController.add(null);
    }
    filtrationModel.page = page;
    _productsRepo.getProducts(filtrationModel.toJson()).then((response) async {
      _isLoading = false;
      if (_productsResponse == null) {
        _productsResponse = response.data;
      } else {
        _productsResponse?.products?.addAll(response.data?.products ?? []);
        _productsResponse?.pagination = response.data?.pagination;
      }
      productsController.add(
        Pair(
          _productsResponse?.products ?? [],
          _productsResponse?.pagination ?? PaginationModel(),
        ),
      );
    }).onError((error, stackTrace) {
      handleStreamError(error, productsController);
    });
  }

  void loadMore() {
    if (_isLoading) return;
    getProducts(page: _productsResponse?.pagination?.nextPage ?? 0);
  }

  Future<ProductsResponse?> getProductsCount() async {
    filtrationModel.page = 1;
    view.showProgress();
    try {
      var baseResponse =
          await _productsRepo.getProducts(filtrationModel.toJson());
      view.hideProgress();
      return baseResponse.data;
    } catch (e) {
      handleError(e);
    }
    return null;
  }

  @override
  void onDispose() {
    _productsRepo.dispose();
    productsController.close();
  }
}
