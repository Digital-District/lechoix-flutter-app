import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../product/data/models/products_response.dart';
import '../repositories/product_repository.dart';

class GetMostRatedProducts extends UseCase<ProductsResponseNoPagination, NoParams> {
  final ProductsRepository repository;
  GetMostRatedProducts({required this.repository});
  @override
  Future<Either<Failure, ProductsResponseNoPagination>> call( NoParams params) async {
    return await repository.getMostRatedProducts();
  }
   
}

