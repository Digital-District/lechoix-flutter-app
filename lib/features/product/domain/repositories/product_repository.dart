import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/product_details.dart';
import '../../data/models/products_response.dart';
import '../usecases/get_latest_products.dart';

abstract class ProductsRepository {
  Future<Either<Failure, ProductsResponse>> getProducts(
     {required int id});
  Future<Either<Failure, ProductsResponse>> getLatestProducts(HomeListsParams params);
  Future<Either<Failure, ProductsResponse>> getMostSellerProducts(HomeListsParams params);
  Future<Either<Failure, ProductsResponseNoPagination>> getMostRatedProducts();
  Future<Either<Failure, ProductDetailsResponse>> getProductDetails(
     {required int id});
}
