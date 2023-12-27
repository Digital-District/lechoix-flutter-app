import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../injection_container/injection_container.dart';
import 'data/datasources/filter_datasource.dart';
import 'data/repositories/filters_respository_impl.dart';
import 'domain/repositories/filters_respositories.dart';
import 'domain/usecases/get_brans.dart';
import 'presentation/cubit/filter_cubit.dart';

Future<void> initFiltersInjection(GetIt sl) async {
  //* cubit
  sl.registerFactory(() => FilterCubit(
        getbrands: sl(),
      ));

  //*useCase
  sl.registerLazySingleton(() => GetBrands(repository: sl()));

  //* Repository
  sl.registerLazySingleton<FiltersRepository>(
    () => FiltersRepositoryImpl(
      remote: sl(),
    ),
  );

  //* Data sources
  sl.registerLazySingleton<FiltersRemoteDataSource>(
    () => FiltersRemoteDataSourceImpl(
      helper: sl(),
    ),
  );
}

List<BlocProvider> filtersBlocs(BuildContext context) => [
      BlocProvider<FilterCubit>(
        create: (BuildContext context) => sl<FilterCubit>()..fGetBrands(),
      ),
    ];
