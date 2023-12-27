import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/visitor_order_model.dart';
import '../repositories/orders_repository.dart';

class VisitorOrderProduct
    extends UseCase<VisitorOrderResponse, VisitorOrderProductParams> {
  final OrdersRepository repository;
  VisitorOrderProduct({required this.repository});
  @override
  Future<Either<Failure, VisitorOrderResponse>> call(
      VisitorOrderProductParams params) async {
    return await repository.visitorOrder(params: params);
  }
}

class VisitorOrderProductParams {
  List<int>? productId;
  List<int>? quantits;
  List<int>? prices;
  double? total;
  int? addressId;
  int? couponId;
  int? discount;
  int? shippingCost;
  String? method;
  String? firstName;
  String? lastName;
  String? phone;
  String? password;
  String? cityId;
  String? address;

  VisitorOrderProductParams({
    this.productId,
    this.quantits,
    this.prices,
    this.firstName,
    this.lastName,
    this.phone,
    this.password,
    this.cityId,
    this.address,
    this.total,
    this.method,
    this.couponId,
    this.discount,
  });

  Map<String, dynamic> toMap() {
    return {
      "product_ids": productId.toString(),
      "quantitys": quantits.toString(),
      "prices": prices.toString(),
      "first_name": firstName.toString(),
      "last_name": lastName.toString(),
      "phone": phone.toString(),
      "password": password.toString(),
      "city_id": cityId.toString(),
      "address_text": address.toString(),
      "total": total.toString(),
      "method": method.toString(),
      "coupon_id": couponId.toString(),
      "coupon_value": discount.toString(),
    };
  }

  factory VisitorOrderProductParams.fromMap(Map<String, dynamic> json) {
    return VisitorOrderProductParams(
      productId: json["product_ids"],
      quantits: json["quantitys"],
      prices: json["prices"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      phone: json["phone"],
      password: json["password"],
      cityId: json["city_id"],
      address: json["address_text"],
      total: json["totalCart"],
      couponId: json["coupon_id"],
      discount: json["coupon_value"],
      method: json["method"],
    );
  }
}
