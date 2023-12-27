import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/notifications_model.dart';
import '../repositories/account_repository.dart';

class GetNotifications extends UseCase<NotificationsResponse, NoParams> {
  final AccountRepository repository;
  GetNotifications({required this.repository});
  @override
  Future<Either<Failure, NotificationsResponse>> call(NoParams params) async {
    return await repository.getNotifications();
  }
}
