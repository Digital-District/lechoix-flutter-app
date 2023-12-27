import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/categories_repository.dart';
import '../../domain/usecases/get_cart.dart';
import '../datasources/cart_datasource.dart';
import '../models/cart_response.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remote;

  CartRepositoryImpl({
    required this.remote,
  });

  @override
  Future<Either<Failure, CartResponse>> getCart(
      {required CartParams params}) async {
    try {
      // final CitiesResponse cachedCities = await local.getCachedCitiesData();
      final response = await remote.getCart(params: params);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
