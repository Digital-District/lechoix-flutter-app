import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/cart_response.dart';
import '../repositories/categories_repository.dart';

class GetCart extends UseCase<CartResponse, CartParams> {
  final CartRepository repository;
  GetCart({required this.repository});
  @override
  Future<Either<Failure, CartResponse>> call(CartParams params) async {
    return await repository.getCart(params: params);
  }
}

class CartParams {
  List<int> productIds;
  CartParams({required this.productIds});
}
