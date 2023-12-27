import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/order_model.dart';
import '../repositories/orders_repository.dart';

class OrderProduct extends UseCase<OrderResponse, OrderProductParams> {
  final OrdersRepository repository;
  OrderProduct({required this.repository});
  @override
  Future<Either<Failure, OrderResponse>> call(OrderProductParams params) async {
    return await repository.order(params: params);
  }
}

class OrderProductParams {
  List<int>? productId;
  List<int>? quantits;
  List<int>? prices;
  double? total;
  int? addressId;
  int? couponId;
  int? discount;
  int? shippingCost;
  String? method;

  OrderProductParams({
    this.addressId,
    this.productId,
    this.quantits,
    this.prices,
    this.total,
    this.couponId,
    this.discount,
    this.shippingCost,
    this.method,
  });

  Map<String, dynamic> toMap() {
    return {
     "product_ids": productId,
     "quantitys": quantits,
     "prices":  quantits,
     "total":  total,
     "method": method,
     "address_id" : addressId,
     "coupon_id": couponId,
     "discount":  discount,
     "shipping_cost" : shippingCost,
    };
  }

  factory OrderProductParams.fromMap(Map<String, dynamic> json) {
    return OrderProductParams(
      addressId: json["address_id"],
      productId: json["product_ids"],
      quantits:  json["quantitys"],
      prices:    json["prices"],
      total:     json["total"],
      couponId:  json["coupon_id"],
      discount:  json["discount"],
   shippingCost: json["shipping_cost"],
      method:    json["method"],
    );
  }
}
