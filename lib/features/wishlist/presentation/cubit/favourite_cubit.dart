// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// import '../../../../core/error/failures.dart';
// import '../../../../core/usecases/usecases.dart';
// import '../../../favourite/domain/usecases/add_to_favourite.dart';
// import '../../../favourite/domain/usecases/get_myfavourites.dart';
// import '../../../product/data/models/products_response.dart';

// part 'favourite_state.dart';

// class FavouriteCubit extends Cubit<FavouriteState> {
//   FavouriteCubit({required this.getMyFavourites, required this.addToFavourite})
//       : super(FavouriteInitial());
//   AddToFavourite addToFavourite;
//   GetMyFavourites getMyFavourites;
//   List<Product> myFavourites = [];
//   bool loading = false;
//   fGetMyFavourites() async {
//     emit(LoadingFavourite());
//     final failOrsuccess = await getMyFavourites(NoParams());
//     failOrsuccess.fold((fail) {
//       if (fail is ServerFailure) {
//         fail.message;
//       }
//     }, (success) async {
//       myFavourites = success.data!;
//       emit(FavouriteLoaded(data: success.data!));
//     });
//   }

//   fAddToFavourite(productId) async {
//     emit(AddFavouriteLoading());
//     loading = true;
//     final failOrsuccess =
//         await addToFavourite(AddToFavouriteParams(productId: productId));
//     failOrsuccess.fold((fail) {
//       if (fail is ServerFailure) {
//         fail.message;
//         log(fail.message);
//       }
//       loading = false;
//     }, (success) async {
//       log("fav  $success");
//       loading = false;
//       emit(AddFavouriteChange());
//       if (!success) {
//         myFavourites.removeWhere((item) => item.id == productId);
//         emit(FavouriteLoaded(data: myFavourites));
//       }
//     });
//   }

//   doFavourite(bool fav, int productId) async {
//     switch (fav == false) {
//       case true:
//         fav = true;
//         fAddToFavourite(productId);

//         break;
//       case false:
//         fav = false;
//         fAddToFavourite(productId);
//     }
//   }
// }
