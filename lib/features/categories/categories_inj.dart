import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../injection_container/injection_container.dart';
import 'data/datasources/categories_remote_data_source.dart';
import 'data/repositories/categories_respository_impl.dart';
import 'domain/repositories/categories_repository.dart';
import 'domain/usecases/get_categories.dart';
import 'domain/usecases/get_sub_categories.dart';
import 'domain/usecases/show_category_product.dart';
import 'presentation/bloc/categories_cubit.dart';

Future<void> initCategoriesInjection(GetIt sl) async {
  //* cubit
  sl.registerFactory(() => CategoriesCubit(
        getCategories: sl(),
        subCategories: sl(),
        showCategoryProduct: sl(),
      ));

  //*useCase
  sl.registerLazySingleton(() => GetCategories(repository: sl()));
  sl.registerLazySingleton(() => GetSubCategories(repository: sl()));
  sl.registerLazySingleton(() => ShowCategoryProduct(repository: sl()));

  //* Repository
  sl.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(
      remote: sl(),
    ),
  );

  //* Data sources
  sl.registerLazySingleton<CategoriesRemoteDataSource>(
    () => CategoriesRemoteDataSourceImpl(
      helper: sl(),
    ),
  );
}

List<BlocProvider> categoriesBlocs(BuildContext context) => [
      BlocProvider<CategoriesCubit>(
          create: (BuildContext context) => sl<CategoriesCubit>()
            ..fGetCategories().then((v) {
              if (context.read<CategoriesCubit>().categories!.isNotEmpty) {
                context.read<CategoriesCubit>().fGetSubCategories(
                    // emitFreshLoading(
                    context.read<CategoriesCubit>().categories!.first.id);
              }
            })),
    ];
