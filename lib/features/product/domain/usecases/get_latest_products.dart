import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../product/data/models/products_response.dart';
import '../repositories/product_repository.dart';

class GetLatestProducts extends UseCase<ProductsResponse, HomeListsParams> {
  final ProductsRepository repository;
  GetLatestProducts({required this.repository});
  @override
  Future<Either<Failure, ProductsResponse>> call(HomeListsParams params) async {
    return await repository.getLatestProducts(params);
  }
}

class HomeListsParams {
  int? page;
  HomeListsParams({this.page});
}
