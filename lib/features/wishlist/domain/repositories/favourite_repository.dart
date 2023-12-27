
import 'package:dartz/dartz.dart';
import '../../../product/data/models/products_response.dart';

import '../../../../core/error/failures.dart';

abstract class FavouritesRepository {
  Future<Either<Failure, ProductsResponseNoPagination>> getMyFavourites();
  Future<Either<Failure, bool>> addToFavourite({required int productId});
}
