import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/my_order_model.dart';
import '../repositories/orders_repository.dart';

class GetMyOrders extends UseCase<MyOrdersResponse, NoParams> {
  final OrdersRepository repository;
  GetMyOrders({required this.repository});
  @override
  Future<Either<Failure, MyOrdersResponse>> call(NoParams params) async {
    return await repository.getMyOrders();
  }
}
