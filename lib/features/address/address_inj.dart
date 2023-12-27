import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../injection_container/injection_container.dart';
import 'data/datasources/address_datasource.dart';
import 'data/repositories/address_repository_impl.dart';
import 'domain/repositories/address_repository.dart';
import 'domain/usecases/add_address.dart';
import 'domain/usecases/delete_address.dart';
import 'domain/usecases/edit_address.dart';
import 'domain/usecases/get_myAddresses.dart';
import 'presentation/cubit/address_cubit.dart';

Future<void> initAddressInjection(GetIt sl) async {
  //* cubit
  sl.registerFactory(() => AddressCubit(
        addAddress: sl(),
        deleteAddress: sl(),
        editAddress: sl(),
        getMyAddresses: sl(),
      ));

  //*useCase
  sl.registerLazySingleton(() => AddAddress(repository: sl()));
  sl.registerLazySingleton(() => DeleteAddress(repository: sl()));
  sl.registerLazySingleton(() => EditAddress(repository: sl()));
  sl.registerLazySingleton(() => GetMyAddresses(repository: sl()));

  //* Repository
  sl.registerLazySingleton<AddressRepository>(
    () => AddressRepositoryImpl(
      remote: sl(),
    ),
  );

  //* Data sources

  sl.registerLazySingleton<AddressRemoteDataSource>(
    () => AddressRemoteDataSourceImpl(
      helper: sl(),
    ),
  );
}

List<BlocProvider> addressBlocs(BuildContext context) => [
      BlocProvider<AddressCubit>(
          create: (BuildContext context) => sl<AddressCubit>()),
    ];
