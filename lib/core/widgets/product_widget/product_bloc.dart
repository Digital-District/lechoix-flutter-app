import 'dart:async';

import 'package:lechoix/base/base_bloc.dart';
import 'package:lechoix/base/base_view.dart';
import 'package:lechoix/data/model/ProductModel.dart';
import 'package:lechoix/repo/ProductsRepo.dart';

class ProductBloc extends BaseBloc {
  ProductBloc(BaseView view) : super(view);
  ProductsRepo _productsRepo = ProductsRepo();
  StreamController<ProductModel?> productDetailsController = StreamController();
  ProductModel? productModel;
  int productId = 0;

  void setProductId(int productId) {
    this.productId = productId;
  }

  void getProductDetails() {
    productDetailsController.add(null);
    _productsRepo.getProductDetails(productId).then((value) {
      productModel = value.data;
      productDetailsController.add(value.data);
    }).onError((error, stackTrace) {
      handleStreamError(error, productDetailsController);
    });
  }

  Future<ProductModel?> setFavorite(int productId) async {
    try {
      var res = await _productsRepo.setFavorite(productId);
      return res.data;
    } catch (e) {
      handleError(e);
    }
    return null;
  }

  @override
  void onDispose() {
    productDetailsController.close();
    _productsRepo.dispose();
  }
}
