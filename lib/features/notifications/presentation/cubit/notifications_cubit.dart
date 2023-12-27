import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../../core/widgets/toast.dart';
import '../../../account/data/models/notifications_model.dart';
import '../../../account/domain/usecases/get_notifications.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit({required this.getNotifications})
      : super(NotificationsInitial());
  GetNotifications getNotifications;
  List<NotificationModel> notification = [];

  Future<void> fGetNotifications() async {
    emit(NotificationsLoading());
    final failOrUser = await getNotifications(NoParams());
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        showToast(fail.message);
      }
    }, (page) {
      notification = page.notifications!;
      if (notification.isEmpty) {
        emit(NotificationsEmpty());
      } else {
        emit(NotificationsLoaded(notifications: notification));
      }
    });
  }
}
