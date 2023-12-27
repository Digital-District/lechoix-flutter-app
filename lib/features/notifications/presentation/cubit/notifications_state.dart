part of 'notifications_cubit.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
 final List notifications;
  const NotificationsLoaded({required this.notifications});
    @override
  List<Object> get props => [notifications];
}

class NotificationsLoading extends NotificationsState {}
class NotificationsEmpty extends NotificationsState {}
