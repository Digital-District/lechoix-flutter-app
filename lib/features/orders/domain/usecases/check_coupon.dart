import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/coupon_model.dart';
import '../repositories/orders_repository.dart';

class CheckCoupon
    extends UseCase<CouponResponse, CheckCouponParams> {
  final OrdersRepository repository;
  CheckCoupon({required this.repository});
  @override
  Future<Either<Failure, CouponResponse>> call(
      CheckCouponParams params) async {
    return await repository.checkCoupon(code: params.code);
  }
}

class CheckCouponParams {
  String code;
  CheckCouponParams({required this.code});
}
