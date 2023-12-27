import 'dart:async';

import 'package:lechoix/features/address/data/datasources/AddressRepo.dart';
import 'package:lechoix/features/cart/data/datasources/CartRepo.dart';

import '../../../../../core/base/base_bloc.dart';
import '../../../../../core/cache/user_cache.dart';
import '../../../../../data/address/AddressModel.dart';
import '../../../../../data/base/ErrorModel.dart';
import '../../../../../data/cart/AddToCartRequestModel.dart';
import '../../../../../data/cart/CartResponse.dart';

class CartBloc extends BaseBloc {
  CartBloc(super.view);
  final CartRepo _repo = CartRepo();
  final AddressRepo _addressRepo = AddressRepo();
  bool isCoupon = false;
  String couponErrorMes = "";

  Future<bool> addToCart(AddToCartRequestModel model) async {
    view.showProgress();
    try {
      var baseResponse = await _repo.addToCart(model);
      print(baseResponse);
      view.showSuccessMsg(baseResponse.message ?? "");
      view.hideProgress();
      UserCache.instance.updateCartCount(1, true);
      return true;
    } catch (e) {
      handleError(e);
    }
    return false;
  }

  Future<bool> deleteFromCart(int cartId) async {
    view.showProgress();
    try {
      var baseResponse = await _repo.deleteFromCart(cartId);
      view.showSuccessMsg(baseResponse.message ?? "");
      view.hideProgress();
      return true;
    } catch (e) {
      handleError(e);
    }
    return false;
  }

  Future<CartResponse?> updateCartItemQuantity(
      int cartId, int quantity, String? discountCode) async {
    view.showProgress();
    try {
      var baseResponse =
          await _repo.updateCartItemQuantity(cartId, quantity, discountCode);
      if (baseResponse.data != null) {
        UserCache.instance
            .updateCartCount(baseResponse.data?.productsCount ?? 0, false);
      }
      view.hideProgress();
      return baseResponse.data;
    } catch (e) {
      handleError(e);
    }
    return null;
  }

  Future<CartResponse?> getCart(
      {int? addressId, int? paymentMethod, String? discountCode}) async {
    Map<String, dynamic> data = {};
    if (addressId != null) {
      data["address_id"] = addressId;
      print("addressId $addressId");
    }
    if (paymentMethod != null) {
      data["payment_method"] = paymentMethod;
      print("paymentMethod $paymentMethod");
    }
    if (discountCode != null) {
      data["discount_code"] = discountCode;
      print("discountCode $discountCode");
    }
    try {
      var baseResponse = await _repo.getCart(data);
      UserCache.instance
          .updateCartCount(baseResponse.data?.productsCount ?? 0, false);

      return baseResponse.data;
    } catch (e) {
      handleError(e);
    }
    return null;
  }

  Future<AddressModel?> getShippingAddress() async {
    try {
      var baseResponse = await _addressRepo.getMyAddress();
      List<AddressModel> addresses = baseResponse.data?.addresses ?? [];
      if (addresses.isEmpty) {
        return null;
      } else {
        AddressModel mode = addresses[0];
        for (var item in addresses) {
          if (item.isDefault ?? false) {
            mode = item;
            break;
          }
        }
        return mode;
      }
    } catch (e) {
      handleError(e);
    }
    return null;
  }

  Future<bool> checkDiscount(String code) async {
    isCoupon = true;
    couponErrorMes = "";
    view.showProgress();
    try {
      await _repo.checkDiscount({"code": code});
      // view.showSuccessMsg(baseResponse.message ?? "");
      view.hideProgress();
      isCoupon = false;
      return true;
    } catch (e) {
      handleError(e);
    }
    return false;
  }

  @override
  void onError(ErrorResponse errorModel) {
    if (isCoupon) {
      view.hideProgress();
      couponErrorMes = errorModel.message ?? "";
      isCoupon = false;
    } else {
      super.onError(errorModel);
    }
  }

  @override
  void onDispose() {
    _repo.dispose();
    _addressRepo.dispose();
  }
}
