import 'dart:async';

import 'package:lechoix/features/orders/data/datasources/OrdersRepo.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../../data/orders/OrderModel.dart';
import '../../../../data/orders/MyOrdersResponse.dart';

class OrdersBloc extends BaseBloc {
  OrdersBloc(super.view) {}

  final OrdersRepo _repo = OrdersRepo();
  StreamController<MyOrdersResponse?> controller = StreamController();

  Future<OrderModel?> makeOrder(int addressId, int? paymentMethod,
      String discountCode, String paymentId, String invoiceId) async {
    view.showProgress();

    Map<String, dynamic> data = {
      "address_id": addressId,
    };

    if (paymentMethod != null) {
      data["payment_method"] = paymentMethod;
    }

    if (discountCode.isNotEmpty) {
      data["discount_code"] = discountCode;
    }
    if (paymentId.isNotEmpty) {
      data["payment_id"] = paymentId;
    }
    if (invoiceId.isNotEmpty) {
      data["invoice_id"] = invoiceId;
    }
    try {
      var baseResponse = await _repo.makeOrder(data);
      view.hideProgress();

      return baseResponse.data;
    } catch (e) {
      handleError(e);
    }
    return null;
  }

  void getMyOrders() {
    controller.add(null);
    _repo.getMyOrders().then((baseResponse) {
      controller.add(baseResponse.data);
    }).onError((error, stackTrace) {
      handleStreamError(error, controller);
    });
  }

  Future<dynamic> cancelOrder(int orderId) async {
    view.showProgress();
    try {
      var baseResponse = await _repo.cancelOrder(orderId);
      view.hideProgress();
      view.showSuccessMsg(baseResponse.message ?? "");
      return baseResponse;
    } catch (e) {
      handleError(e);
    }
    return null;
  }

  @override
  void onDispose() {
    _repo.dispose();
  }
}
