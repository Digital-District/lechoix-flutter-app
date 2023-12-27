import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../product/data/models/products_response.dart';
import '../repositories/product_repository.dart';
import 'get_latest_products.dart';

class GetMostSellerProducts extends UseCase<ProductsResponse, HomeListsParams > {
  final ProductsRepository repository;
  GetMostSellerProducts({required this.repository});
  @override
  Future<Either<Failure, ProductsResponse>> call( HomeListsParams params ) async {
    return await repository.getMostSellerProducts(params);
  }
   
}


