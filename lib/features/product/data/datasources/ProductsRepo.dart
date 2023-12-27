import 'package:lechoix/core/util/network/endpoints.dart';
import 'package:lechoix/data/Enumeration.dart';
import '../../../../core/base/base_repo.dart';
import '../../../../data/base/BaseResponse.dart';
import '../../../../data/model/ProductModel.dart';
import '../../../../data/response/ProductsResponse.dart';

class ProductsRepo extends BaseRepo {
  Future<BaseResponse<ProductsResponse>> getProducts(
      Map<String, dynamic> param) {
    return networkManager.request<ProductsResponse>(
      Endpoints.getProducts,
      Method.GET,
      data: param,
    );
  }

  Future<BaseResponse<ProductModel>> getProductDetails(int productId) {
    return networkManager.request<ProductModel>(
      "${Endpoints.getProducts}$productId",
      Method.GET,
    );
  }

  Future<BaseResponse<ProductsResponse>> getFavorites() {
    return networkManager.request<ProductsResponse>(
      Endpoints.favorites,
      Method.GET,
    );
  }

  Future<BaseResponse<ProductModel>> setFavorite(int productId) {
    return networkManager.request<ProductModel>(
      Endpoints.favorites,
      Method.POST,
      data: {"product_id": productId},
    );
  }
}
