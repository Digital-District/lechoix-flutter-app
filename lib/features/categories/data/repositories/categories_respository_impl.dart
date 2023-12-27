import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/categories_repository.dart';
import '../../domain/usecases/show_category_product.dart';
import '../datasources/categories_remote_data_source.dart';
import '../models/categories_model.dart';
import '../models/show_category_model.dart';
import '../models/subCategories_response.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource remote;

  CategoriesRepositoryImpl({
    required this.remote,
  });

  @override
  Future<Either<Failure, CategoriesResponse>> getCategories() async {
    try {
      // final CitiesResponse cachedCities = await local.getCachedCitiesData();
      final response = await remote.getCategories();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, ShowCategoryResponse>> showCategoryProduct(
      {required ShowCategoryProductParams params}) async {
    try {
      // final CitiesResponse cachedCities = await local.getCachedCitiesData();
      final response = await remote.showCategoryProduct(params: params);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, SubCategoriesByCatResponse>> getSubCategoriesByCat(
      {required int id}) async {
    try {
      // final CitiesResponse cachedCities = await local.getCachedCitiesData();
      final response = await remote.getSubCategoriesByCat(id: id);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
