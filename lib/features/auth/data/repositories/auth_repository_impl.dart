import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/local/auth_local_datasource.dart';
import '../../domain/entities/check_otp.dart';
import '../../domain/entities/forget_password_response.dart';
import '../../domain/entities/login.dart';
import '../../domain/entities/register.dart';
import '../../domain/entities/send_code.dart';
import '../../domain/entities/update_password.dart';
import '../../domain/repositories/auth_repositoriy.dart';
import '../../domain/usecase/check_otp.dart';
import '../../domain/usecase/forget_password_usecase.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../domain/usecase/register_usecase.dart';
import '../../domain/usecase/send_code_usecase.dart';
import '../../domain/usecase/update_password.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  AuthRepositoryImpl({required this.remote, required this.local});

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      final token = await local.getCacheUserAccessToken();
      await remote.logout();
      await local.clearData();
      // await Hive.box("myBox").clear();
      return const Right("result");
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CheckOtpResponse>> checkOtp(
      {required CheckOtpParams params}) async {
    try {
      final response = await remote.checkOtp(params: params);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

//register
  @override
  Future<Either<Failure, RegisterResponse>> register(
      {required CompleteRegisterParams params}) async {
    try {
      final response = await remote.register(params: params);
      await local.cacheUserAccessToken(token: response.token!);
      await local.cacheUserLoginInfo(
          params: LoginParams(
              userPassword: params.userPassword, userPhone: params.userPhone));
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, LoginResponse>> autoLogin() async {
    try {
      final LoginParams userLoginInfo = await local.getCacheUserLoginInfo();
      final user = await remote.login(params: userLoginInfo);
      await local.cacheUserData(user: user.data!);
      await local.cacheUserAccessToken(token: user.token!);
      log(user.data.toString());

      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NoCachedUserException {
      return Left(NoCachedUserFailure());
    }
  }

  @override
  Future<Either<Failure, UpdatePasswordResponse>> updatePassword(
      {required UpdatePasswordParams params}) async {
    try {
      final response = await remote.updatePassword(params: params);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, SendCodeForForgetPasswordResponse>> sendCode(
      {required SendCodeParams params}) async {
    try {
      final response = await remote.sendCode(params: params);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, ForgetPasswordResponse>> forgetPassword(
      {required ForgetPassowrdParams params}) async {
    try {
      final response = await remote.forgetPassword(params: params);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> deleteAccount() async {
    try {
      final token = await local.getCacheUserAccessToken();
      await remote.deleteAccount();
      await local.clearData();
      // await Hive.box("myBox").clear();
      return const Right("result");
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, LoginResponse>> login(
      {required LoginParams params}) async {
    try {
      LoginResponse response = await remote.login(params: params);
      User user = response.data!;
      String token = response.token!;
      log("impl$response");
      log("token$token");
      await local.cacheUserData(user: user);
      await local.cacheUserAccessToken(token: token);
      await local.cacheUserLoginInfo(params: params);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
