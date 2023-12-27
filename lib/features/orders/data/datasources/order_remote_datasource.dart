import 'dart:developer';

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/api_basehelper.dart';
import '../../domain/usecases/order.dart';
import '../../domain/usecases/order_visitor.dart';
import '../models/coupon_model.dart';
import '../models/my_order_model.dart';
import '../models/order_details.dart';
import '../models/order_model.dart';
import '../models/payment_methods_model.dart';
import '../models/visitor_order_model.dart';

const getMyOrderApi = "orders";
const orderDetailsApi = "order/";
const checkCouponApi = "check-coupon?code=";
const orderProductApi = "order/store";
const cancelOrderApi = "order/cancel";
const paymentMethodsApi = "payment-methods";
const visitorOrderApi = "post-checkout";

abstract class OrdersRemoteDataSource {
  Future<MyOrdersResponse> getMyOrders();
  Future<PaymentMethodResponse> getPaymentMethod();
  Future<OrderDetailsResponse> getOrderDetails({required int id});
  Future<CouponResponse> checkCoupon({required String code});
  Future<OrderResponse> order({required OrderProductParams params});
  Future<VisitorOrderResponse> visitorOrder(
      {required VisitorOrderProductParams params});
  Future<String> cancelOrder({required int id});
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final ApiBaseHelper helper;

  OrdersRemoteDataSourceImpl({
    required this.helper,
  });

  @override
  Future<CouponResponse> checkCoupon({required String code}) async {
    try {
      final response = await helper.get(
        url: "$checkCouponApi$code",
      );
      if (response["success"] == "true") {
        return CouponResponse.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<PaymentMethodResponse> getPaymentMethod() async {
    try {
      final response = await helper.get(
        url: paymentMethodsApi,
      );
      if (response["success"] == "true") {
        return PaymentMethodResponse.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<OrderResponse> order({required OrderProductParams params}) async {
    try {
      log({
        "product_ids": params.productId,
        "quantitys": params.quantits,
        "prices": params.prices,
        "total": params.total,
        "method": params.method,
        "address_id": params.addressId,
        "coupon_id": params.couponId,
        "discount": params.discount,
        "shipping_cost": params.shippingCost,
      }.toString());
      final response = await helper.post(url: orderProductApi, body: {
        "product_ids": params.productId.toString(),
        "quantitys": params.quantits.toString(),
        "prices": params.prices.toString(),
        "total": params.total.toString(),
        "method": params.method.toString(),
        "address_id": params.addressId.toString(),
        "coupon_id": params.couponId.toString(),
        "discount": params.discount.toString(),
        "shipping_cost": params.shippingCost.toString(),
      });
      log(response.toString());
      if (response["success"] == "true") {
        return OrderResponse.fromJson(response);
      } else {
        log(response);
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<MyOrdersResponse> getMyOrders() async {
    try {
      final response = await helper.get(
        url: getMyOrderApi,
      );
      // return unit;
      if (response["success"] == true) {
        return MyOrdersResponse.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<OrderDetailsResponse> getOrderDetails({required int id}) async {
    try {
      final response = await helper.get(
        url: "$orderDetailsApi$id",
      );
      if (response["success"] == true) {
        return OrderDetailsResponse.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> cancelOrder({required int id}) async {
    try {
      final response = await helper.post(url: cancelOrderApi, body: {"id": id});
      if (response["status"] == true) {
        return response["message"];
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<VisitorOrderResponse> visitorOrder(
      {required VisitorOrderProductParams params}) async {
    try {
      final response =
          await helper.post(url: visitorOrderApi, body: params.toMap());
      log(response.toString());
      if (response["success"] == "true") {
        return VisitorOrderResponse.fromJson(response);
      } else {
        log(response);
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
