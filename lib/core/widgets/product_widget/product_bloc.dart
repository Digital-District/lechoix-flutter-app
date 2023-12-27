import 'dart:async';

import 'package:lechoix/features/product/data/datasources/ProductsRepo.dart';

import '../../../data/model/ProductModel.dart';
import '../../base/base_bloc.dart';

class ProductBloc extends BaseBloc {
  ProductBloc(super.view);
  final ProductsRepo _productsRepo = ProductsRepo();
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
      // var res = await _productsRepo.setFavorite(productId);
      // return res.data;
    } catch (e) {
      handleError(e);
    }
    return null;
  }

  @override
  void onDispose() {
    productDetailsController.close();
    // _productsRepo.dispose();
  }
}
