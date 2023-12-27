import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/cities.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_data_source.dart';
import '../datasources/home_remote_data_source.dart';
import '../model/slider_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remote;
  final HomeLocalDataSource local;

  HomeRepositoryImpl({required this.remote, required this.local});

  @override
  Future<Either<Failure, CitiesResponse>> getCities() async {
    try {
      // final CitiesResponse cachedCities = await local.getCachedCitiesData();
      final response = await remote.getCities();
      await local.cacheCities(cities: response);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, HomeSliderResponse>> getSlides() async {
    try {
      // final CitiesResponse cachedCities = await local.getCachedCitiesData();
      final response = await remote.getSlides();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
