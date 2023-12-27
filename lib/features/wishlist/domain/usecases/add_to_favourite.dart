// import 'package:dartz/dartz.dart';

// import '../../../../core/error/failures.dart';
// import '../../../../core/usecases/usecases.dart';
// import '../../../favourite/domain/repositories/favourite_repository.dart';

// class AddToFavourite extends UseCase<bool, AddToFavouriteParams> {
//   final FavouritesRepository repository;
//   AddToFavourite({required this.repository});
//   @override
//   Future<Either<Failure, bool>> call(AddToFavouriteParams params) async {
//     return await repository.addToFavourite(productId: params.productId);
//   }
// }

// class AddToFavouriteParams {
//   int productId;
//   AddToFavouriteParams({required this.productId});
// }
