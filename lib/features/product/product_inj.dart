import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../product/data/datasources/products_data_source.dart';
import 'data/repositories/products_repository_impl.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/usecases/get_latest_products.dart';
import 'domain/usecases/get_most_rated.dart';
import 'domain/usecases/get_most_seller.dart';
import 'domain/usecases/get_product_details.dart';
import 'domain/usecases/get_products.dart';

Future<void> initProductInjection(GetIt sl) async {
  //* cubit
  // sl.registerFactory(() => ProductCubit(
  //   getProductDetails:sl(),
  //   getLatestProducts:sl(),
  //   getMostRatedProducts:sl(),
  //   getMostSellerProducts:sl(),
  //     ));

  //*useCase
  sl.registerLazySingleton(() => GetProducts(repository: sl()));
  sl.registerLazySingleton(() => GetLatestProducts(repository: sl()));
  sl.registerLazySingleton(() => GetProductDetails(repository: sl()));
  sl.registerLazySingleton(() => GetMostRatedProducts(repository: sl()));
  sl.registerLazySingleton(() => GetMostSellerProducts(repository: sl()));

  //* Repository
  sl.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(
      remote: sl(),
    ),
  );

  //* Data sources

  sl.registerLazySingleton<ProductsRemoteDataSource>(
    () => ProductsRemoteDataSourceImpl(
      helper: sl(),
    ),
  );
}

List<BlocProvider> productBlocs(BuildContext context) => [
      // BlocProvider<ProductCubit>(create: (BuildContext context) => sl<ProductCubit>()
      //     ),
    ];
