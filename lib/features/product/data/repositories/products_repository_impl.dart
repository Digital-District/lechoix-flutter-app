import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/get_latest_products.dart';
import '../datasources/products_data_source.dart';
import '../models/product_details.dart';
import '../models/products_response.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remote;

  ProductsRepositoryImpl({
    required this.remote,
  });

  @override
  Future<Either<Failure, ProductsResponse>> getProducts(
      {required int id}) async {
    try {
      final response = await remote.getProducts(id: id);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
    //  on CacheException {
    //   return Left(CacheFailure());
    // }
  }

  @override
  Future<Either<Failure, ProductDetailsResponse>> getProductDetails(
      {required int id}) async {
    try {
      final response = await remote.getProductDetails(id: id);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
    //  on CacheException {
    //   return Left(CacheFailure());
    // }
  }

  @override
  Future<Either<Failure, ProductsResponse>> getLatestProducts(HomeListsParams params) async {
    try {
      final response = await remote.getLatestProducts( params);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ProductsResponseNoPagination>> getMostRatedProducts() async {
    try {
      final response = await remote.getMostRatedProducts();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
    //  on CacheException {
    //   return Left(CacheFailure());
    // }
  }

  @override
  Future<Either<Failure, ProductsResponse>> getMostSellerProducts(HomeListsParams params) async {
    try {
      final response = await remote.getMostSellerProducts(params);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
    // on CacheException {
    //   return Left(CacheFailure());
    // }
  }
}
