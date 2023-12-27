import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/orders_repository.dart';

class CancelOrder
    extends UseCase<String, CancelOrderParams> {
  final OrdersRepository repository;
  CancelOrder({required this.repository});
  @override
  Future<Either<Failure, String>> call(
      CancelOrderParams params) async {
    return await repository.cancelOrder(id: params.id);
  }
}

class CancelOrderParams {
  int id;
  CancelOrderParams({required this.id});
}
