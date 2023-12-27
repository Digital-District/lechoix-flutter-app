import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/product_details.dart';
import '../repositories/product_repository.dart';

class GetProductDetails
    extends UseCase<ProductDetailsResponse, ProductDetailsParams> {
  final ProductsRepository repository;
  GetProductDetails({required this.repository});
  @override
  Future<Either<Failure, ProductDetailsResponse>> call(
      ProductDetailsParams params) async {
    return await repository.getProductDetails(id: params.id);
  }
}

class ProductDetailsParams {
  int id;
  ProductDetailsParams({required this.id});
}
