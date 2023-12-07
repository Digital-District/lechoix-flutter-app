import 'CartModel.dart';
import 'CartSummaryModel.dart';

class CartResponse {
  List<CartModel>? cart;
  int? productsCount;
  CartSummaryModel? cartSummary;

  CartResponse({
    this.cart,
    this.productsCount,
    this.cartSummary,
  });

  CartResponse.fromJson(dynamic json) {
    if (json['cart'] != null) {
      cart = [];
      json['cart'].forEach((v) {
        cart?.add(CartModel.fromJson(v));
      });
    }
    productsCount = json['products_count'];
    cartSummary = json['cart_summary'] != null
        ? CartSummaryModel.fromJson(json['cart_summary'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (cart != null) {
      map['cart'] = cart?.map((v) => v.toJson()).toList();
    }
    map['products_count'] = productsCount;
    if (cartSummary != null) {
      map['cart_summary'] = cartSummary?.toJson();
    }
    return map;
  }
}
