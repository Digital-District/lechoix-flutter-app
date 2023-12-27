import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/filters_respositories.dart';
import '../datasources/filter_datasource.dart';
import '../models/brands_model.dart';

class FiltersRepositoryImpl implements FiltersRepository {
  final FiltersRemoteDataSource remote;

  FiltersRepositoryImpl({
    required this.remote,
  });

  @override
  Future<Either<Failure, BrandsResponse>> getBrands() async {
    try {
      // final CitiesResponse cachedCities = await local.getCachedCitiesData();
      final response = await remote.getBrands();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
