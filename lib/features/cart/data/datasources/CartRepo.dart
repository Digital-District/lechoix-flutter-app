import 'package:lechoix/core/util/network/endpoints.dart';
import 'package:lechoix/data/Enumeration.dart';

import '../../../../core/base/base_repo.dart';
import '../../../../data/base/BaseResponse.dart';
import '../../../../data/cart/AddToCartRequestModel.dart';
import '../../../../data/cart/CartResponse.dart';

class CartRepo extends BaseRepo {
  Future<BaseResponse<dynamic>> addToCart(AddToCartRequestModel model) {
    return networkManager.request<dynamic>(Endpoints.cart, Method.POST,
        data: model.toJson());
  }

  Future<BaseResponse<dynamic>> deleteFromCart(int cartId) {
    String url = "${Endpoints.cart}/$cartId";
    return networkManager.request<dynamic>(
      url,
      Method.DELETE,
    );
  }

  Future<BaseResponse<CartResponse>> updateCartItemQuantity(
      int cartId, int quantity, String? discountCode) {
    String url = "${Endpoints.cart}/$cartId";
    Map<String, dynamic> data = {"quantity": quantity};
    if (discountCode != null) {
      data["discount_code"] = discountCode;
    }
    return networkManager.request<CartResponse>(url, Method.PATCH, data: data);
  }

  Future<BaseResponse<CartResponse>> getCart(Map<String, dynamic> data) {
    return networkManager.request<CartResponse>(Endpoints.cart, Method.GET,
        data: data);
  }

  Future<BaseResponse<dynamic>> checkDiscount(Map<String, dynamic> data) {
    return networkManager.request<dynamic>(Endpoints.checkDiscount, Method.GET,
        data: data);
  }
}
