import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../injection_container/injection_container.dart';
import '../cart/data/datasources/cart_datasource.dart';
import '../cart/data/repositories/cart_respository_impl.dart';
import '../cart/domain/repositories/categories_repository.dart';
import '../cart/domain/usecases/get_cart.dart';
import '../cart/presentation/cubit/cart/cart_cubit.dart';
import '../cart/presentation/cubit/counter/counter_cubit.dart';
import 'data/datasources/order_local_datasource.dart';
import 'data/datasources/order_remote_datasource.dart';
import 'data/repositories/order_repository_impl.dart';
import 'domain/repositories/orders_repository.dart';
import 'domain/usecases/cancel_order.dart';
import 'domain/usecases/check_coupon.dart';
import 'domain/usecases/get_cach_methods.dart';
import 'domain/usecases/get_myOrders.dart';
import 'domain/usecases/order.dart';
import 'domain/usecases/order_visitor.dart';
import 'domain/usecases/show_order.dart';

Future<void> initOrdersInjection(GetIt sl) async {
  //* cubit
  // sl.registerFactory(() => OrdersCubit(
  //       cancelOrder: sl(),
  //       checkCoupon: sl(),
  //       getMyOrders: sl(),
  //       orderProduct: sl(),
  //       showOrderDetails: sl(),
  //       getPaymentMethod: sl(),
  //       visitorOrder: sl(),
  //     ));

  sl.registerFactory(() => CartCubit(
        getCart: sl(),
      ));

  sl.registerFactory(() => CounterCubit());

  //*useCase
  sl.registerLazySingleton(() => CancelOrder(repository: sl()));
  sl.registerLazySingleton(() => CheckCoupon(repository: sl()));
  sl.registerLazySingleton(() => GetMyOrders(repository: sl()));
  sl.registerLazySingleton(() => OrderProduct(repository: sl()));
  sl.registerLazySingleton(() => ShowOrderDetails(repository: sl()));
  sl.registerLazySingleton(() => GetPaymentMethod(repository: sl()));
  sl.registerLazySingleton(() => GetCart(repository: sl()));
  sl.registerLazySingleton(() => VisitorOrderProduct(repository: sl()));

  //* Repository
  sl.registerLazySingleton<OrdersRepository>(
    () => OrdersRepositoryImpl(
      remote: sl(),
      local: sl(),
    ),
  );

  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      remote: sl(),
    ),
  );

  //* Data sources

  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(
      helper: sl(),
    ),
  );
  sl.registerLazySingleton<OrdersRemoteDataSource>(
    () => OrdersRemoteDataSourceImpl(
      helper: sl(),
    ),
  );
  sl.registerLazySingleton<OrderLocalDataSource>(
    () => OrderLocalDataSourceImpl(sharedPreference: sl()),
  );
}

List<BlocProvider> ordersBlocs(BuildContext context) => [
      // BlocProvider<OrdersCubit>(
      //     create: (BuildContext context) => sl<OrdersCubit>()),
      BlocProvider<CartCubit>(
          create: (BuildContext context) => sl<CartCubit>()),
      BlocProvider<CounterCubit>(
          create: (BuildContext context) => sl<CounterCubit>()),
    ];
