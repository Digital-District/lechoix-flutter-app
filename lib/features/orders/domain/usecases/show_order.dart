import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/order_details.dart';
import '../repositories/orders_repository.dart';

class ShowOrderDetails
    extends UseCase<OrderDetailsResponse, OrderDetailsParams> {
  final OrdersRepository repository;
  ShowOrderDetails({required this.repository});
  @override
  Future<Either<Failure, OrderDetailsResponse>> call(
      OrderDetailsParams params) async {
    return await repository.getOrderDetails(id: params.id);
  }
}

class OrderDetailsParams {
  int id;
  OrderDetailsParams({required this.id});
}
