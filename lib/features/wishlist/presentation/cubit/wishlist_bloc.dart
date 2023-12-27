import 'dart:async';

import 'package:lechoix/features/product/data/datasources/ProductsRepo.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../data/model/ProductModel.dart';

class WishlistBloc extends BaseBloc {
  WishlistBloc(super.view) {
    getWishlist();
  }

  final ProductsRepo _productsRepo = ProductsRepo();
  StreamController<List<ProductModel>?> productsController = StreamController();

  List<ProductModel> favorites = [];

  void getWishlist() {
    productsController.add(null);
    _productsRepo.getFavorites().then((value) {
      favorites = value.data?.products ?? [];
      productsController.add(favorites);
    }).onError((error, stackTrace) {
      handleStreamError(error, productsController);
    });
  }

  void removeFromFavorites(ProductModel productModel) {
    if (productModel.isFavorite == false) {
      favorites.remove(productModel);
      productsController.add(favorites);
    }
  }

  @override
  void onDispose() {
    productsController.close();
    _productsRepo.dispose();
  }
}
