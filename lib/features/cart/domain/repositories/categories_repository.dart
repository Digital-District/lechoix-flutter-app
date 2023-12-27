import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/cart_response.dart';
import '../usecases/get_cart.dart';

abstract class CartRepository {
  Future<Either<Failure, CartResponse>> getCart({required CartParams params});
}
