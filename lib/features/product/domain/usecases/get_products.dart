import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/products_response.dart';
import '../repositories/product_repository.dart';

class GetProducts extends UseCase<ProductsResponse, GetProductParams> {
  final ProductsRepository repository;
  GetProducts({required this.repository});
  @override
  Future<Either<Failure, ProductsResponse>> call( GetProductParams params) async {
    return await repository.getProducts(id: params.id);
  }
}

class GetProductParams {
  int id;
  GetProductParams({required this.id});
}
