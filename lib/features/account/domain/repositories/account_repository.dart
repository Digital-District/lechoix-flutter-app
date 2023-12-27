import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/edit_profile_model.dart';
import '../../data/models/notifications_model.dart';
import '../../data/models/static_page.dart';
import '../usecases/contact_us.dart';
import '../usecases/edit_profile.dart';

abstract class AccountRepository {
  Future<Either<Failure, NotificationsResponse>> getNotifications();
  Future<Either<Failure, StaticPageResponse>> getStaticPage({required int page});
  Future<Either<Failure, EditProfileResponse>> editProfile({required EditProfileParams params});
  Future<Either<Failure, String>> contactUs({required ContactUsParams params});

}
