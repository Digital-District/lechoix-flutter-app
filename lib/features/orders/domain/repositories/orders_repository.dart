import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/coupon_model.dart';
import '../../data/models/my_order_model.dart';
import '../../data/models/order_details.dart';
import '../../data/models/order_model.dart';
import '../../data/models/payment_methods_model.dart';
import '../../data/models/visitor_order_model.dart';
import '../usecases/order.dart';
import '../usecases/order_visitor.dart';

abstract class OrdersRepository {

  Future<Either<Failure, MyOrdersResponse>> getMyOrders();
  Future<Either<Failure, PaymentMethodResponse>> getPaymentMethod();
  Future<Either<Failure, OrderDetailsResponse>> getOrderDetails({required int id});
  Future<Either<Failure, CouponResponse>> checkCoupon({required String code});
  Future<Either<Failure, OrderResponse>> order({required OrderProductParams params});
  Future<Either<Failure, VisitorOrderResponse>> visitorOrder({required VisitorOrderProductParams params});
  Future<Either<Failure, String>> cancelOrder({required int id});
}
