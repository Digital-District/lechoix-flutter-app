import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/payment_methods_model.dart';
import '../repositories/orders_repository.dart';

class GetPaymentMethod extends UseCase<PaymentMethodResponse, NoParams> {
  final OrdersRepository repository;
  GetPaymentMethod({required this.repository});
  @override
  Future<Either<Failure, PaymentMethodResponse>> call( NoParams params) async {
    return await repository.getPaymentMethod();
  }
   
}

