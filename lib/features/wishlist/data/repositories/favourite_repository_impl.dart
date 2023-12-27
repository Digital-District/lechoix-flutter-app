// import 'package:dartz/dartz.dart';

// import '../../../../core/error/exceptions.dart';
// import '../../../../core/error/failures.dart';
// import '../../../favourite/data/datasources/favourite_datasource.dart';
// import '../../../favourite/domain/repositories/favourite_repository.dart';
// import '../../../product/data/models/products_response.dart';

// class FavouritesRepositoryImpl implements FavouritesRepository {
//   final FavouritesRemoteDataSource remote;
//   // final AuthLocalDataSource local;

//   FavouritesRepositoryImpl({
//     required this.remote,
//     // required this.local,
//   });

//   @override
//   Future<Either<Failure, bool>> addToFavourite({required int productId}) async {
//     try {
//       final response = await remote.addToFavourites(productId: productId);
//       // final token = local.getCacheUserAccessToken;

//       return Right(response);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(message: e.message));
//     } on CacheException {
//       return Left(CacheFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, ProductsResponseNoPagination>>
//       getMyFavourites() async {
//     try {
//       final response = await remote.getMyFavourites();
//       return Right(response);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(message: e.message));
//     } on CacheException {
//       return Left(CacheFailure());
//     }
//   }
// }
