import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/local/auth_local_datasource.dart';
import '../../../auth/domain/usecase/login_usecase.dart';
import '../../domain/repositories/account_repository.dart';
import '../../domain/usecases/contact_us.dart';
import '../../domain/usecases/edit_profile.dart';
import '../datasources/account_datasource.dart';
import '../models/edit_profile_model.dart';
import '../models/notifications_model.dart';
import '../models/static_page.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource remote;
  final AuthLocalDataSource local;

  AccountRepositoryImpl({
    required this.remote,
    required this.local,
  });

  @override
  Future<Either<Failure, NotificationsResponse>> getNotifications() async {
    try {
      final response = await remote.getNotifications();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, EditProfileResponse>> editProfile(
      {required EditProfileParams params}) async {
    try {
      await local.getCachedUserData();
      await local.getCacheUserLoginInfo();
      final response = await remote.editProfile(params: params);
      await local.cacheUserData(user: response.user!);
      await local.cacheUserLoginInfo(
          params: LoginParams(
              userPassword: params.userPassword, userPhone: params.userPhone));

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, StaticPageResponse>> getStaticPage(
      {required int page}) async {
    try {
      final response = await remote.getStaticPage(page: page);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> contactUs(
      {required ContactUsParams params}) async {
    try {
      final response = await remote.contactUs(params: params);

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
