import 'OrderModel.dart';

class MyOrdersResponse {
  List<OrderModel>? pendingList;
  List<OrderModel>? cancelledList;

  MyOrdersResponse.fromJson(dynamic json) {
    if (json['pending'] != null) {
      pendingList = [];
      json['pending'].forEach((v) {
        pendingList?.add(OrderModel.fromJson(v));
      });
    }

    if (json['cancelled'] != null) {
      cancelledList = [];
      json['cancelled'].forEach((v) {
        cancelledList?.add(OrderModel.fromJson(v));
      });
    }
  }
}
