import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'data/datasources/home_remote_data_source.dart';
import 'domain/repositories/home_repository.dart';
import 'domain/useCases/get_cities.dart';
import 'domain/useCases/get_slides.dart';
import 'presentation/bloc/home/home_cubit.dart';
import '../../injection_container/injection_container.dart';
import 'data/datasources/home_local_data_source.dart';
import 'data/repositories/home_respository_impl.dart';

Future<void> initHomeInjection(GetIt sl) async {
  //* cubit
  sl.registerFactory(
      () => HomeCubit(getCities: sl(), getProducts: sl(), getSlides: sl()));
  // sl.registerFactory(() => FavouriteCubit(addToFavourite: sl(), getMyFavourites: sl(),));
  // sl.registerFactory(() => ProductCubit(
  //       getProductDetails: sl(),
  //     ));

  //*useCase
  sl.registerLazySingleton(() => GetCities(repository: sl()));
  sl.registerLazySingleton(() => GetSlides(repository: sl()));
  // sl.registerLazySingleton(() => AddToFavourite(repository: sl()));
  // sl.registerLazySingleton(() => GetMyFavourites(repository: sl()));

  //* Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remote: sl(),
      local: sl(),
    ),
  );
  // sl.registerLazySingleton<FavouritesRepository>(
  //   () => FavouritesRepositoryImpl(
  //     remote: sl(),
  //   ),
  // );

  //* Data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(
      helper: sl(),
    ),
  );
  // sl.registerLazySingleton<FavouritesRemoteDataSource>(
  //   () => FavouritesRemoteDataSourceImpl(
  //     helper: sl(),
  //   ),
  // );

  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(
      sharedPreference: sl(),
    ),
  );
}

List<BlocProvider> homeBlocs(BuildContext context) => [
      BlocProvider<HomeCubit>(
        create: (BuildContext context) => sl<HomeCubit>()..fGetCities(),
      ),
      // BlocProvider<ProductCubit>(
      //     create: (BuildContext context) => sl<ProductCubit>()),
      BlocProvider<HomeCubit>(
          create: (BuildContext context) => sl<HomeCubit>()..fGetHomeSlides()),
    ];
