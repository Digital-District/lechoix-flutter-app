import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lechoix/features/auth/domain/usecase/delete_account.dart';
import 'package:lechoix/features/auth/domain/usecase/log_out.dart';
import 'package:lechoix/features/auth/presentation/cubit/auto_login/auto_login_cubit.dart';
import 'package:lechoix/features/auth/presentation/cubit/log_out/auth_cubit.dart';
import 'package:lechoix/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:lechoix/features/auth/presentation/cubit/register/register_cubit.dart';
import '../../core/local/auth_local_datasource.dart';
import '../../injection_container/injection_container.dart';
import 'data/datasources/auth_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repositoriy.dart';
import 'domain/usecase/auto_login.dart';
import 'domain/usecase/login_usecase.dart';
import 'domain/usecase/register_usecase.dart';
import 'presentation/cubit/delete_account/delete_account_cubit.dart';

Future<void> initAuthInjection(GetIt sl) async {
  //* cubit
  sl.registerFactory(() => RegisterCubit(
        registerUseCase: sl(),
      ));
  sl.registerFactory(() => AutoLoginCubit(autoLogin: sl()));
  sl.registerFactory(() => LoginCubit(sl()));
  // sl.registerFactory(() => AccountCubit(sl(), sl(), sl()));
  // sl.registerFactory(() => NotificationsCubit(getNotifications: sl() ));
  sl.registerFactory(() => LogOutCubit(logout: sl()));
  sl.registerFactory(() => DeleteAccountCubit(logout: sl()));
  // sl.registerFactory(() => CheckOtpCubit(checkOtp: sl()));
  // sl.registerFactory(() => UpdatePasswordCubit(updatePassword: sl()));
  // sl.registerFactory(() => SendCodeCubit(sendCodeUseCase: sl()));
  // sl.registerFactory(() => ForgetPasswordCubit(forgetPassword: sl()));

  //*useCase
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => AutoLogin(repository: sl()));
  sl.registerLazySingleton(() => RegisterUseCase(repository: sl()));
  // sl.registerLazySingleton(() => EditProfile(repository: sl()));
  // sl.registerLazySingleton(() => GetNotifications(repository: sl()));
  // sl.registerLazySingleton(() => GetStaticPage(repository: sl()));
  // sl.registerLazySingleton(() => ContactUs(repository: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteAccountUseCase(repository: sl()));
  // sl.registerLazySingleton(() => CheckOtpUseCase(repository: sl()));
  // sl.registerLazySingleton(() => UpdatePasswordUseCase(repository: sl()));
  // sl.registerLazySingleton(() => SendCodeUseCase(repository: sl()));
  // sl.registerLazySingleton(() => ForgetPasswordUseCase(repository: sl()));

  //* Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remote: sl(),
      local: sl(),
    ),
  );
  // sl.registerLazySingleton<AccountRepository>(
  //   () => AccountRepositoryImpl(
  //     remote: sl(),
  //     local: sl(),
  //   ),
  // );

  //* Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      helper: sl(),
    ),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      sharedPreference: sl(),
    ),
  );
  // sl.registerLazySingleton<AccountRemoteDataSource>(
  //   () => AccountRemoteDataSourceImpl(
  //     helper: sl(),
  //   ),
  // );
}

List<BlocProvider> authBlocs(BuildContext context) => [
      BlocProvider<LoginCubit>(
          create: (BuildContext context) => sl<LoginCubit>()),
      BlocProvider<RegisterCubit>(
          create: (BuildContext context) => sl<RegisterCubit>()),
      BlocProvider<AutoLoginCubit>(
        create: (BuildContext context) => sl<AutoLoginCubit>()..fAutoLogin(),
      ),
  //     BlocProvider<AccountCubit>(
  //         // create: (BuildContext context) => sl<AccountCubit>()..getUserData()),
  //         create: (BuildContext context) => sl<AccountCubit>()),
  // BlocProvider<NotificationsCubit>(
  //       create: (BuildContext context) => sl<NotificationsCubit>()..fGetNotifications(),),
      BlocProvider<LogOutCubit>(
          create: (BuildContext context) => sl<LogOutCubit>()),
      BlocProvider<DeleteAccountCubit>(
          create: (BuildContext context) => sl<DeleteAccountCubit>()),

    
      // ),
      // BlocProvider<SendCodeCubit>(
      //   create: (BuildContext context) => sl<SendCodeCubit>(),
      // ),
      // BlocProvider<ForgetPasswordCubit>(
      //   create: (BuildContext context) => sl<ForgetPasswordCubit>(),
      // ),
    ];
